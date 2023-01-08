//
//  OrgsViewModel.swift
//  All About Olaf X
//
//  Created by Drew Volz on 8/18/20.
//

import Combine
import SwiftUI

final class OrgsViewModel: ObservableObject {
    private(set) var orgsResponse: [Org]?

    private let fetchProvider = Fetch()
    private var publishers = [AnyCancellable]()

    func search(org: Org, query: String) -> Bool {
        let query = query.lowercased()
        let name = org.name.lowercased()
        let category = org.category.lowercased()

        return query.isEmpty || name.contains(query) || category.contains(query)
    }

    func fetch() {
        fetchProvider.getOrgs()
            .map { $0 }
            .sink(receiveCompletion: { _ in },
                  receiveValue: { self.orgsResponse = $0.value })
            .store(in: &publishers)
    }
}
