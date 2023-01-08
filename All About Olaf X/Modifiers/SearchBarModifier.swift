//
//  SearchBarModifier.swift
//  All About Olaf X
//
//  Created by Drew Volz on 8/2/20.
//

import SwiftUI

struct SearchBarModifier: ViewModifier {
    let searchbar: SearchBar

    func body(content: Content) -> some View {
        content
            .overlay(
                ViewControllerResolver { viewController in
                    viewController.navigationItem.searchController = self.searchbar.searchController
                }
                .frame(width: 0, height: 0)
            )
    }
}

struct TokenizedSearchBarModifier: ViewModifier {
    let searchbar: TokenSearchBar
    
    func body(content: Content) -> some View {
        content
            .overlay(
                ViewControllerResolver { viewController in
                    viewController.navigationItem.searchController = self.searchbar.searchController
                }
                .frame(width: 0, height: 0)
            )
    }
}


extension View {
    func add(searchbar: SearchBar) -> some View {
        return modifier(SearchBarModifier(searchbar: searchbar))
    }
    
    func add(searchbar: TokenSearchBar) -> some View {
        return modifier(TokenizedSearchBarModifier(searchbar: searchbar))
    }
}
