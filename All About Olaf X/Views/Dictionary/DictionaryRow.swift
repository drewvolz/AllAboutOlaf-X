//
//  DictionaryRow.swift
//  AllAboutOlafX
//
//  Created by Drew Volz on 10/30/19.
//  Copyright © 2019 Drew Volz. All rights reserved.
//

import SwiftUI

struct DictionaryRow: View {
    @State var term: Term

    var body: some View {
        VStack(alignment: .leading) {
            Text(term.word).font(.headline)

            Text(term.definition)
                .font(.subheadline)
                .lineLimit(3)
        }
    }
}

struct DictionaryRow_Previews: PreviewProvider {
    static let index: Int = .random(in: 0 ..< AppState.dictionaryData.data.count)

    static var previews: some View {
        DictionaryRow(term: AppState.dictionaryData.data[index])
            .padding()
    }
}
