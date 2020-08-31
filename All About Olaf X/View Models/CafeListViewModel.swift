//
//  CafeList.swift
//  Bon Appetit
//
//  Created by Drew Volz on 8/3/20.
//

import Combine
import SwiftUI

final class CafeListViewModel: ObservableObject {
    @Published private(set) var cafeListResponse: [CafeListResponse]? = []

    private let fetchProvider = Fetch()
    private var publishers = [AnyCancellable]()
    
    func fetch() {
        fetchProvider.getCafeList()
            .sink(receiveCompletion: { _ in },
                  receiveValue: { self.cafeListResponse = $0.value })
            .store(in: &publishers)
    }

    func filterList(cafe: CafeListResponse, query: String, searchbarInstance: UISearchBar) -> Bool {
        let scopedQuery = getScopedValue(searchbar: searchbarInstance) ?? ""

        if !scopedQuery.isEmpty {
            return (
                cafe.desc.lowercased().contains(scopedQuery.lowercased()) &&
                    (query.isEmpty || cafe.label.lowercased().contains(query.lowercased()))
            )
        } else {
            return (
                query.isEmpty ||
                    cafe.label.lowercased().contains(query.lowercased()) ||
                    cafe.desc.lowercased().contains(query.lowercased()) ||
                    cafe.desc.lowercased().contains(scopedQuery.lowercased())
            )
        }
    }

    private func getScopedValue(searchbar: UISearchBar) -> String? {
        guard let scopes = searchbar.scopeButtonTitles else {
            return ""
        }

        if scopes.count > 0 {
            if scopes[searchbar.selectedScopeButtonIndex] == "All" {
                return ""
            } else {
                return scopes[searchbar.selectedScopeButtonIndex]
            }
        }

        return ""
    }
}
