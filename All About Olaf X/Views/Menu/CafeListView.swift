//
//  CafeListView.swift
//  Bon Appetit
//
//  Created by Drew Volz on 8/3/20.
//

import SwiftUI

struct CafeListView: View {
    @EnvironmentObject var appState: AppState

    @ObservedObject var cafeListViewModel = CafeListViewModel()
    @ObservedObject var menuViewModel = MenuListViewModel()
    @ObservedObject var searchbar = SearchBar()

    func CafeList() -> some View {
        Group {
            if cafeListViewModel.cafeListResponse?.isEmpty == true {
                ProgressView("Loading…")
            } else {
                List(cafeListViewModel.cafeListResponse?.filter { cafe in
                    let searchbarInstance = searchbar.searchController.searchBar
                    return cafeListViewModel.filterList(cafe: cafe,
                                                    query: searchbar.text,
                                                    searchbarInstance: searchbarInstance)
                } ?? []) { cafe in
                    ListRow(cafe: cafe)
                }
                .insetGroupedStyle()
                .resignKeyboardOnDragGesture()
                .onAppear(perform: searchbarInit)
            }
        }
        .add(searchbar: searchbar)
        .navigationTitle("Bon Appetit")
    }

    func ListRow(cafe: CafeListResponse) -> some View {
        NavigationLink(destination:
                        CafeDetailView(cafeId: cafe.id)
                        .environmentObject(appState)
                        .navigationTitle(cafe.label)) {
            VStack(alignment: .leading) {
                Text(cafe.label.uppercaseFirst())
                    .font(.body)
                    .fontWeight(.bold)
                    .lineLimit(1)

                Text(cafe.desc)
                    .font(.subheadline)
                    .lineLimit(1)
            }
        }
    }

    func searchbarInit() {
        let scopes = ["Northfield", "All"]
        searchbar.initScopes(scopeList: scopes, appState: appState)
    }

    init() {
        cafeListViewModel.fetch()
    }

    var body: some View {
        CafeList()
    }
}

struct CafeListView_Previews: PreviewProvider {
    static var previews: some View {
        CafeListView()
    }
}
