//
//  SearchUserRow.swift
//  AllAboutOlafX
//
//  Created by Drew Volz on 10/26/19.
//  Copyright © 2019 Drew Volz. All rights reserved.
//

import SwiftUI

struct UserRow: View {
    @ObservedObject var viewmodel: SearchUserViewModel
    @State var user: SearchUser

    var body: some View {
        HStack {
            UrlImageView(urlString: user.thumbnail.absoluteString)

            VStack(alignment: .leading) {
                Text(user.displayName).font(.headline)

                if !user.campusLocations!.isEmpty && !user.campusLocations![0].buildingabbr.isEmpty {
                    if let displayTitle = user.displayTitle {
                        Text("\(user.campusLocations!.first!.buildingabbr) \(user.campusLocations!.first!.room) • \(displayTitle.stringByDecodingHTMLEntities)")
                            .font(.subheadline)
                            .lineLimit(1)
                    } else {
                        Text("\(user.campusLocations!.first!.buildingabbr) \(user.campusLocations!.first!.room)")
                    }
                } else {
                    if let displayTitle = user.displayTitle {
                        Text(displayTitle)
                            .font(.subheadline)
                            .lineLimit(1)
                    }
                }
            }
        }
        .frame(height: 60)
    }
}

struct SearchUserRow_Preview: PreviewProvider {
    static var previews: some View {
        ForEach(["iPhone SE", "iPhone X", "iPhone XS Max"], id: \.self) { deviceName in
            Group {
                UserRow(viewmodel: SearchUserViewModel(), user: AppState.mockUserData.results[0])
                    .environment(\.colorScheme, .dark)
                    .environment(\.sizeCategory, .extraSmall)

                UserRow(viewmodel: SearchUserViewModel(), user: AppState.mockUserData.results[0]).environment(\.colorScheme, .light)
                    .environment(\.sizeCategory, .large)

                UserRow(viewmodel: SearchUserViewModel(), user: AppState.mockUserData.results[0]).environment(\.colorScheme, .dark)
                    .environment(\.sizeCategory, .accessibilityExtraExtraExtraLarge)
            }
            .previewLayout(.fixed(width: 300, height: 70))
            .previewDevice(PreviewDevice(rawValue: deviceName))
            .previewDisplayName(deviceName)
        }
    }
}
