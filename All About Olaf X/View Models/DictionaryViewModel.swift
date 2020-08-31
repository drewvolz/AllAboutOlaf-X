//
//  DictionaryViewModel.swift
//  AllAboutOlafX
//
//  Created by Drew Volz on 10/30/19.
//  Copyright © 2019 Drew Volz. All rights reserved.
//

import Combine
import SwiftUI

final class DictionaryViewModel: ObservableObject {
    private(set) var terms: [Term] = []
    
    init() {
        self.terms = AppState.dictionaryData.data
    }

    internal func filterTermsOnTokens(term: Term, searchbar: TokenSearchBar) -> Bool {
        let tokens = Set(searchbar.searchController.searchBar.searchTextField.tokens)
        
        guard tokens.isEmpty else {
            let searchHit: [Bool] = tokens.map { token in
                let token = token.representedObject as? String ?? ""
                return search(term: term, query: token)
            }
        
            return searchHit.contains(true)
        }
        
        return true
    }
    
    internal func search(term: Term, query: String) -> Bool {
        let query = query.lowercased()
        let word = term.word.lowercased()
        let definition = term.definition.lowercased()
        
        return query.isEmpty || word.contains(query) || definition.contains(query)
    }
}
