//
//  Binding.swift
//  All About Olaf X
//
//  Created by Drew Volz on 8/26/20.
//  https://forums.swift.org/t/promoting-binding-value-to-binding-value/31055/3
//

import SwiftUI

extension Binding {
    func unwrap<Wrapped>() -> Binding<Wrapped>? where Optional<Wrapped> == Value {
        guard let value = self.wrappedValue else { return nil }
        return Binding<Wrapped>(
            get: {
                return value
            },
            set: { value in
                self.wrappedValue = value
            }
        )
    }
}
