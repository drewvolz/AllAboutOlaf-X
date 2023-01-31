//
//  DictionaryList.swift
//  AllAboutOlafX
//
//  Created by Drew Volz on 10/30/19.
//  Copyright © 2019 Drew Volz. All rights reserved.
//

import SwiftUI

struct DictionaryList: View {
    @ObservedObject var viewmodel = DictionaryViewModel()
    @ObservedObject var tokenizedSearchBar = TokenSearchBar()

    init() {
        UITableView.appearance().tableFooterView = UIView()
    }

    var body: some View {
        List(viewmodel.terms.filter { term in
            viewmodel.filterTermsOnTokens(term: term, searchbar: tokenizedSearchBar)
        }) { term in
            NavigationLink(destination: DictionaryDetail(term: term)) {
                DictionaryRow(term: term)
            }
        }
        .defaultStyle()
        .add(searchbar: tokenizedSearchBar)
        .resignKeyboardOnDragGesture()
        .navigationBarTitle("Dictionary")
    }
}

struct DictionaryList_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DictionaryList()
        }
    }
}
