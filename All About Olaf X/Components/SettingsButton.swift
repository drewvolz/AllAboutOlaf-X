//
//  SettingsButton.swift
//  All About Olaf X
//
//  Created by Drew Volz on 8/20/20.
//

import SwiftUI

struct SettingsButton: View {
    @EnvironmentObject var appState: AppState
    @Binding var showing: Bool
    
    var body: some View {
        Button(action: {
            self.showing.toggle()
        }, label: {
            Image(symbol: .gear)
        })
        .buttonStyle(PlainButtonStyle())
        .sheet(isPresented: $showing) {
            SettingsView(showingSettings: $showing)
                .environmentObject(self.appState)
        }
    }
}

struct SettingsButton_Previews: PreviewProvider {
    static var previews: some View {
        SettingsButton(showing: .constant(false))
    }
}
