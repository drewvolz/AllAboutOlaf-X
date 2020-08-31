//
//  SearchUserViewModel.swift
//  AllAboutOlafX
//
//  Created by Drew Volz on 10/26/19.
//  Copyright © 2019 Drew Volz. All rights reserved.
//

import SwiftUI
import Combine

final class SearchUserViewModel: ObservableObject {
    @Published private(set) var users = [SearchUser]()

    private let fetchProvider = Fetch()

    private var cancellable: Cancellable? {
        didSet { oldValue?.cancel() }
    }

    deinit {
        cancellable?.cancel()
    }

    internal func configure(searchtext: Published<String>.Publisher) {
        setupPublisher(publisher: searchtext)
    }

    private func setupPublisher(publisher: Published<String>.Publisher) {
        cancellable = publisher
            .debounce(for: .milliseconds(500), scheduler: DispatchQueue.main)
            .removeDuplicates()
            .filter({ !$0.isEmpty })
            .setFailureType(to: Error.self)
            .flatMap {
                self.fetchProvider.searchDirectory(url: self.buildUrl(query: $0))
            }
            .subscribe(on: DispatchQueue.global())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in },
                receiveValue: { [weak self] in
                    self?.users = $0.value.results
                })
    }
    
    private func buildUrl(query: String) -> String {
        var urlComponents = URLComponents(string: Urls.api.directory)!
        urlComponents.queryItems = [
            URLQueryItem(name: "query", value: query),
            URLQueryItem(name: "fuseaction", value: "SearchResults"),
            URLQueryItem(name: "format", value: "json")
        ]
        
        guard let url = urlComponents.url?.absoluteString else {
            preconditionFailure("Bad directory URL")
        }
        
        return url
    }
}
