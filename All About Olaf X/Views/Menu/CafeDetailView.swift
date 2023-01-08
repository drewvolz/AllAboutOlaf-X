//
//  CafeDetailView.swift
//  All About Olaf X
//
//  Created by Drew Volz on 8/2/20.
//

import SwiftUI

struct CafeDetailView: View {
    @ObservedObject var menuListViewModel = MenuListViewModel()
    @ObservedObject var searchbar = SearchBar()

    private var cafeId: String

    init(cafeId: String) {
        self.cafeId = cafeId
    }

    var body: some View {
        // Todo: this splitting on which view is showing based upon search
        // being active causes a UI bug where the list scrolls on top of
        // the navigation bar and search bar.
        Group {
            if searchbar.filtering {
                FilterView(menuViewModel: menuListViewModel)
            } else {
                StationView(menuViewModel: menuListViewModel, cafeId: cafeId)
            }
        }
        .add(searchbar: self.searchbar)
    }
}

struct CafeDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CafeDetailView(cafeId: "")
    }
}
