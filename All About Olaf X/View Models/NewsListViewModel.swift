//
//  NewsList.swift
//  Bon Appetit
//
//  Created by Drew Volz on 8/17/20.
//

import Combine
import SwiftUI

final class NewsListViewModel: ObservableObject {
    @Published private(set) var newsListResponse: [NewsResponse]?

    private let fetchProvider = Fetch()
    private var publishers = [AnyCancellable]()
    
    func fetch(name: String) {
        let url = Urls.api.cccnews + name

        fetchProvider.getNews(url: url)
            .map { $0 }
            .sink(receiveCompletion: { _ in },
                  receiveValue: { self.newsListResponse = $0.value })
            .store(in: &publishers)
    }
}
