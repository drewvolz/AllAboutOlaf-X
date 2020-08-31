//
//  NewsList.swift
//  Bon Appetit
//
//  Created by Drew Volz on 8/17/20.
//

import SwiftUI

struct NewsFeed: View {
    @ObservedObject var viewmodel = NewsListViewModel()
    @Environment(\.openURL) var openURL

    var named: String

    init(named: String) {
        self.named = named
    }

    var body: some View {
        List(viewmodel.newsListResponse ?? []) { story in
            Button(action: {
                if let link = story.link {
                    openURL(URL(string: link)!)
                }
            }, label: {
                NewsRow(story: story)
            })
        }
        .defaultStyle()
        .onAppear {
            viewmodel.fetch(name: named)
        }
    }
}

struct NewsList_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            NewsFeed(named: "stolaf")
        }
    }
}
