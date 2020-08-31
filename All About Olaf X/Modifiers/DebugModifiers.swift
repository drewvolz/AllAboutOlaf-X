//
//  ViewModifiers.swift
//  All About Olaf X
//
//  Created by John Sundell on 8/23/20
//  Modified by Drew Volz on 8/23/20
//  https://swiftbysundell.com/articles/building-swiftui-debugging-utilities/
//

import SwiftUI

extension View {
    // MARK: View modifiers

    func debugModifier<T: View>(_ modifier: (Self) -> T) -> some View {
        #if DEBUG
        return modifier(self)
        #else
        return self
        #endif
    }

    func debugBorder(_ color: Color = .red, width: CGFloat = 1) -> some View {
        return debugModifier {
            $0.border(color, width: width)
        }
    }

    func debugBackground(_ color: Color = .red) -> some View {
        return debugModifier {
            $0.background(color)
        }
    }
    
    // MARK: Action modifiers
    
    func debugAction(_ closure: () -> Void) -> Self {
        #if DEBUG
        closure()
        #endif
        
        return self
    }
    
    func debugPrint(_ value: Any) -> Self {
        debugAction { print(value) }
    }
}
