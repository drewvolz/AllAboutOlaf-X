//
//  Chevron.swift
//  All About Olaf X
//
//  Created by Drew Volz on 8/22/20.
//

import SwiftUI

struct Chevron: View {
    @State var pointing: Pointing

    enum Pointing {
        case left
        case right
    }

    var direction: SFSymbol {
        switch pointing {
        case .left: return .chevronLeft
        case .right: return .chevronRight
        }
    }
    
    var body: some View {
        Image(symbol: direction)
            .imageScale(.small)
            .foregroundColor(Color(.tertiaryLabel))
            .font(.headline)
    }
}
