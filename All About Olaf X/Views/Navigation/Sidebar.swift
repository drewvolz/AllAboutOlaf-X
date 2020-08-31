//
//  Sidebar.swift
//  All About Olaf X
//
//  Created by Drew Volz on 8/20/20.
//

import SwiftUI

struct Sidebar: View {
    @EnvironmentObject var appState: AppState
    @Environment(\.openURL) var openURL

    @State private var showingSettings: Bool = false
    @State private var alertItem: AlertItem?

    @State var selection: Set<NavigationItem> = [.menus]
    
    struct SidebarItemRow: View {
        @State var view: Component

        var body: some View {
            Image(symbol: view.icon).modifier(NavbarIcon())
            Text(view.title)
        }
    }
    
    func ViewRow(view: Component) -> some View {
        NavigationLink(destination: view.destination) {
            SidebarItemRow(view: view)
        }
        .tag(view.id)
    }

    func LinkRow(view: Component) -> some View {
        Button(action: {
            self.alertItem = makeAlertItem(view: view, openURL: openURL)
        }) {
            SidebarItemRow(view: view)
        }
        .buttonStyle(PlainButtonStyle())
        .alert(item: $alertItem) { alertItem in
            Alert(title: alertItem.title,
                  message: alertItem.message,
                  primaryButton: alertItem.primaryButton,
                  secondaryButton: alertItem.secondaryButton
            )}
    }

    var body: some View {
        List(selection: $selection) {
            ForEach(Components.views) { view in
                if appState.showInactiveHomeTiles || view.active ?? false {
                    switch view.type {
                    case .view: ViewRow(view: view)
                    case .url: LinkRow(view: view)
                    }
                }
            }
        }
        .listStyle(SidebarListStyle())
        .preferredColorScheme(appState.isDarkModeEnabled ? .dark : .light)
        .navigationBarItems(trailing: SettingsButton(showing: $showingSettings).environmentObject(appState))
        .navigationBarTitle(UIApplication.bundleName)
    }
}

struct Sidebar_Previews: PreviewProvider {
    static var previews: some View {
        Sidebar()
    }
}
