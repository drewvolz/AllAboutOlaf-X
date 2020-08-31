//
//  DictionaryDetail.swift
//  AllAboutOlafX
//
//  Created by Drew Volz on 10/30/19.
//  Copyright © 2019 Drew Volz. All rights reserved.
//

import SwiftUI
import UIKit

struct DictionaryDetail: View {
    @State var term: Term
    @State var showingSheet = false

    var body: some View {
        ScrollView {
            WrappedTextView(text: $term.definition)
                .padding()
        }
        .navigationBarTitle(term.word)
    }
}

struct DictionaryDetail_Previews: PreviewProvider {
    static let index: Int = .random(in: 0 ..< AppState.dictionaryData.data.count)

    static var previews: some View {
        NavigationView {
            DictionaryDetail(term: AppState.dictionaryData.data[index])
        }
    }
}
