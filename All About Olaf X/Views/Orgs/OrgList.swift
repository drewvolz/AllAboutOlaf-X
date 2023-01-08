//
//  OrgList.swift
//  All About Olaf X
//
//  Created by Drew Volz on 8/18/20.
//

import SwiftUI

struct OrgList: View {
    @ObservedObject var viewmodel = OrgsViewModel()
    @ObservedObject var searchbar = SearchBar()

    init() {
        UITableView.appearance().tableFooterView = UIView()
        viewmodel.fetch()
    }

    var body: some View {
        List(viewmodel.orgsResponse?.filter { org in
            viewmodel.search(org: org, query: searchbar.text)
        } ?? []) { org in
            OrgListRow(org: org)
        }
        .animation(.interactiveSpring())
        .add(searchbar: searchbar)
        .listStyle(DefaultListStyle())
        .resignKeyboardOnDragGesture()
        .navigationBarTitle("Student Orgs")
    }

    func OrgListRow(org: Org) -> some View {
        NavigationLink(destination: OrgDetail(org: org)) {
            VStack(alignment: .leading) {
                Text(org.name)
                    .font(.body)
                    .fontWeight(.bold)
                    .lineLimit(1)

                Text(org.category)
                    .font(.subheadline)
                    .lineLimit(1)
            }
        }
    }
}

struct OrgList_Previews: PreviewProvider {
    static var previews: some View {
        OrgList()
    }
}
