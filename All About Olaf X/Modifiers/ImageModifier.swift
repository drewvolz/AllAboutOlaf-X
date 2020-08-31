//
//  ImageModifier.swift
//  Bon Appetit
//
//  Created by Drew Volz on 8/16/20.
//

import SwiftUI

struct CircleImageModifier: ViewModifier {
    let foreground: Color
    let background: Color

    func body(content: Content) -> some View {
        content
            .frame(width: 25, height: 25)
            .imageScale(.large)
            .foregroundColor(foreground)
            .padding(7)
            .background(background)
            .clipShape(Circle())
    }
}

extension Image {
    func addCircle(foregroundColor: Color, backgroundColor: Color) -> some View {
        return modifier(CircleImageModifier(foreground: foregroundColor, background: backgroundColor))
    }
}
