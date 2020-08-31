//
//  TokenSearchBar.swift
//  All About Olaf X
//
//  Created by João Colaço on 7/2/20
//  Modified by Drew Volz on 8/23/20
//  https://stackoverflow.com/questions/60762749/implement-tokens-in-a-swiftui-textfield
//

import SwiftUI

class TokenSearchBar: NSObject, ObservableObject {
    @Published var searchText = [""]
    private var placeholder = "Search…"
    
    let searchController: UISearchController = UISearchController(searchResultsController: nil)
    var coordinator: Coordinator?
    
    override init() {
        super.init()
        
        coordinator = makeCoordinator()
        
        // Monitor when the search button is tapped, and start/end editing.
        searchController.searchBar.delegate = coordinator
        
        // Monitor when the search controller is presented and dismissed.
        searchController.delegate = self
        
        searchController.searchResultsUpdater = self
        searchController.searchBar.autocapitalizationType = .none
        searchController.searchBar.searchTextField.placeholder = placeholder
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.searchTextField.tokenBackgroundColor = UIColor(named: "AccentColor")
        
        /** Specify that this view controller determines how the search controller is presented.
         The search controller should be presented modally and match the physical size of this view controller.
         */
        searchController.definesPresentationContext = true
    }
    
    internal func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    /// Coordinator and delegate for the searchbar
    
    class Coordinator: NSObject {
        var parent: TokenSearchBar
        
        var searchBar: UISearchBar?
        
        var searchText: [String] = [] {
            didSet {
                guard let searchBar = searchBar else {
                    return
                }
                
                // get the current search array
                var tokenSearchText = searchText
                
                let lastSearchTextItem: String
                
                if tokenSearchText.isEmpty {
                    lastSearchTextItem = ""
                } else {
                    lastSearchTextItem = tokenSearchText.removeLast()
                }
                
                // compare them with the search array
                tokenSearchText.enumerated().forEach {
                    offset, searchString in
                    
                    // get the current tokens.
                    let currentTokens = searchBar.searchTextField.tokens
                    
                    let searchToken = UISearchToken(icon: UIImage(symbol: .tagFill), text: searchString)
                    
                    // check if the number of tokens on display can be displayed with this offset.
                    // if not it will create a new token at the end.
                    if currentTokens.count > offset {
                        
                        // check if the token at this offset has the same object as the searchstring.
                        // if not will insert a new token on this offset.
                        // this assumes that all represented objects are strings
                        if let representedObject = currentTokens[offset].representedObject as? String, representedObject != searchString {
                            
                            let newToken = searchToken
                            newToken.representedObject = searchString
                            
                            searchBar.searchTextField.tokens.insert(newToken, at: offset)
                        }
                        
                    } else {
                        let newToken = searchToken
                        newToken.representedObject = searchString
                        
                        self.searchBar?.searchTextField.tokens.append(newToken)
                    }
                }
                
                // trim the number of tokens to be equal to the tokenSearchText
                let tokensToRemove = searchBar.searchTextField.tokens.count - tokenSearchText.count
                if tokensToRemove > 0 {
                    searchBar.searchTextField.tokens.removeLast(tokensToRemove)
                }
                
                // make the search field text equal to lastSearchTextItem
                if searchBar.text != lastSearchTextItem {
                    searchBar.text = lastSearchTextItem
                }
                
                if parent.searchText != self.searchText {
                    parent.searchText = self.searchText
                }
            }
        }
        
        init(_ searchBar: TokenSearchBar) {
            self.parent = searchBar
        }
    }
}


// MARK: UISearchControllerDelegate

extension TokenSearchBar: UISearchControllerDelegate {

    #warning("Implement suggested searches")
    func setToSuggestedSearches() {
        // Show suggested searches only if we don't have a search token in the search field.
        if searchController.searchBar.searchTextField.tokens.isEmpty {
//            resultsTableController.showSuggestedSearches = true
            
            // We are no longer interested in cell navigating, since we are now showing the suggested searches.
//            resultsTableController.tableView.delegate = resultsTableController
        }
    }
    
    // We are being asked to present the search controller, so from the start - show suggested searches.
    func presentSearchController(_ searchController: UISearchController) {
        searchController.showsSearchResultsController = true
        setToSuggestedSearches()
    }
}

// MARK: UISearchResultsUpdating

extension TokenSearchBar: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        if let searchBarText = searchController.searchBar.text {
            searchText = [searchBarText]
        }
    }
}


// MARK: UISearchBarDelegate

extension TokenSearchBar.Coordinator: UISearchBarDelegate {
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar = searchBar
        
        searchText = []
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar = searchBar
        
        // add a new level to the search
        if searchText.last?.trimmingCharacters(in: .whitespacesAndNewlines) != "" {
            searchText.append("")
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchBar = searchBar
        
        if self.searchText.last != nil,  self.searchText[self.searchText.count - 1] != searchText {
            self.searchText[self.searchText.count - 1] = searchText

            #warning("Implement suggested searches")
//            setToSuggestedSearches()
        } else {
            
            var tokenText = searchBar.searchTextField.tokens.compactMap {
                $0.representedObject as? String
            }
            
            tokenText.append(searchText)
            
            self.searchText = tokenText
  
            #warning("Implement suggested searches")
//            resultsTableController.showSuggestedSearches = false
        }
    }
}
