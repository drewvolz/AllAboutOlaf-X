//
//  NewsRow.swift
//  All About Olaf X
//
//  Created by Drew Volz on 8/19/20.
//

import SwiftUI

struct NewsRow: View {
    @State var showingSheet: Bool = false
    @State var story: NewsResponse

    struct NewsUrlImageView: View {
        @ObservedObject var urlImageModel: UrlImageModel

        static var defaultImage = UIImage(imageLiteralResourceName: "placeholder")

        init(urlString: String?) {
            urlImageModel = UrlImageModel(urlString: urlString)
        }

        var body: some View {
            Image(uiImage: urlImageModel.image ?? UrlImageView.defaultImage)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 70, height: 70)
                .cornerRadius(5)
        }
    }

    var body: some View {
        HStack {
            NewsUrlImageView(urlString: story.featuredImage)

            VStack(alignment: .leading, spacing: 3) {
                Text(story.title)
                    .lineLimit(1)
                    .font(.headline)

                Text(story.excerpt)
                    .lineLimit(3)
                    .font(.subheadline)
            }

            Spacer()
            Chevron(pointing: .right)
        }
        .contextMenu {
            if let link = story.link {
                ActionMenu(label: link, actions: [.share], showingSheet: $showingSheet)
            }
        }
        .sheet(isPresented: $showingSheet, content: {
            ActionShareSheet(type: .link, label: story.link)
        })
    }
}

struct NewsRow_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            List {
            NewsRow(story: NewsResponse(title: "Welcoming the St. Olaf Class of 2024",
                                        excerpt: "Learn more about the St. Olaf class of 2024 and how move-in day has..."))
            
            NewsRow(story: NewsResponse(title: "Welcoming the St. Olaf Class of 2024",
                                        excerpt: "Learn more about the St. Olaf class of 2024 and how move-in day has..."))
            }
            .defaultStyle()
        }
    }
}
