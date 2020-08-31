//
//  HomeBackground.swift
//  All About Olaf X
//
//  Created by Drew Volz on 8/20/20.
//

import SwiftUI

struct HomeBackground: View {
    @EnvironmentObject var appState: AppState
    @Environment(\.accessibilityReduceMotion) var reduceMotion

    var body: some View {
        if reduceMotion || appState.isDarkModeEnabled || appState.isLowPowerEnabled {
            Color("HomeBackground").edgesIgnoringSafeArea(.all)
        } else {
            BubbleBackground()
        }
    }
}
