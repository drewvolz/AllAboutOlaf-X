//
//  SearchUserView.swift
//  AllAboutOlafX
//
//  Created by Drew Volz on 10/26/19.
//  Copyright © 2019 Drew Volz. All rights reserved.
//

import SwiftUI

struct SearchUserView: View {
    @ObservedObject var viewmodel = SearchUserViewModel()
    @ObservedObject var searchbar = SearchBar()

    init() {
        UITableView.appearance().tableFooterView = UIView()

        viewmodel.configure(searchtext: searchbar.$text)
    }

    var body: some View {
        List(viewmodel.users) { user in
            NavigationLink(destination: SearchUserDetailView(user: user)) {
                UserRow(viewmodel: self.viewmodel, user: user)
            }
        }
        .add(searchbar: searchbar)
        .listStyle(DefaultListStyle())
        .resignKeyboardOnDragGesture()
        .navigationBarTitle("Directory")
    }
}

struct SearchUserView_Preview: PreviewProvider {
    static var previews: some View {
        ForEach(["iPhone SE", "iPhone X", "iPhone XS Max"], id: \.self) { deviceName in
            Group {
                NavigationView {
                    SearchUserView()
                        .environment(\.colorScheme, .dark)
                        .environment(\.sizeCategory, .extraSmall)
                }

                NavigationView {
                    SearchUserView()
                        .environment(\.colorScheme, .light)
                        .environment(\.sizeCategory, .large)
                }

                NavigationView {
                    SearchUserView()
                        .environment(\.colorScheme, .dark)
                        .environment(\.sizeCategory, .accessibilityExtraExtraExtraLarge)
                }
            }
            .previewDevice(PreviewDevice(rawValue: deviceName))
            .previewDisplayName(deviceName)
        }
    }
}
