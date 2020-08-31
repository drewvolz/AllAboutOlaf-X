//
//  Navigation.swift
//  All About Olaf X
//
//  Created by Drew Volz on 8/20/20.
//

import SwiftUI

struct Navigation: View {
    @EnvironmentObject var appState: AppState

    var body: some View {
        switch UIDevice.current.userInterfaceIdiom {
        case .phone: iPhoneNavigation
        case .pad: iPadNavigation
        default: EmptyView()
        }
    }

    @ViewBuilder var iPhoneNavigation: some View {
        NavigationView {
            HomeView().environmentObject(self.appState)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }

    var iPadNavigation: some View {
        NavigationView {
            Group {
                Sidebar()
                EmptyView()
            }
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationView {
                Navigation()
            }
        }
    }
}
