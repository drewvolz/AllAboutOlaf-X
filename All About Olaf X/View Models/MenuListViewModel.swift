//
//  MenuList.swift
//  All About Olaf X
//
//  Created by Drew Volz on 8/3/20.
//

import Combine
import SwiftUI

final class MenuListViewModel: ObservableObject {
    @Published private(set) var menuListResponse: MenuResponse?

    private let fetchProvider = Fetch()
    private var publishers = [AnyCancellable]()

    func fetch(cafeId: String) {
        let url = buildUrl(cafeId: cafeId)

        fetchProvider.getCafeMenu(url: url)
            .sink(receiveCompletion: { _ in },
                  receiveValue: { self.menuListResponse = $0.value })
            .store(in: &publishers)
    }
    
    private func buildUrl(cafeId: String) -> String {
        var urlComponents = URLComponents(string: Urls.api.menus)!
        urlComponents.queryItems = [
            URLQueryItem(name: "cafe", value: cafeId),
            URLQueryItem(name: "json", value: "true")
        ]
        
        guard let url = urlComponents.url?.absoluteString else {
            preconditionFailure("Bad directory URL")
        }
        
        return url
    }
}
