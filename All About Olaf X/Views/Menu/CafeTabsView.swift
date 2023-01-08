//
//  CafeTabsView.swift
//  All About Olaf X
//
//  Created by Drew Volz on 8/16/20.
//

import SwiftUI

struct CafeTabsView: View {
    @EnvironmentObject var appState: AppState

    @State private var selection: Tab = .stav

    let stav = "Stav Hall"
    let cage = "The Cage"
    let pause = "The Pause"

    var body: some View {
        TabView(selection: $selection) {
            CafeDetailView(cafeId: "261")
                .environmentObject(self.appState)
                .navigationTitle(stav)
                .tabItem {
                    Label(stav, systemImage: SFSymbol.sCircleFill.rawValue)
                        .accessibility(label: Text(stav))
                }
                .tag(Tab.stav)

            CafeDetailView(cafeId: "262")
                .environmentObject(self.appState)
                .navigationTitle(cage)
                .tabItem {
                    Label(cage, systemImage: SFSymbol.cCircleFill.rawValue)
                        .accessibility(label: Text(cage))
                }
                .tag(Tab.cage)

//            Group {
//                Text(pause)
//                    .navigationTitle(cage)
//            }
//            .tabItem {
//                Label(pause, systemImage: SFSymbol.pCircleFill.rawValue)
//                    .accessibility(label: Text(pause))
//            }
//            .tag(Tab.pause)
        }
        .navigationTitle("Menus")
    }
}

extension CafeTabsView {
    enum Tab {
        case stav
        case cage
        case pause
    }
}

struct CafeTabsView_Previews: PreviewProvider {
    static var previews: some View {
        CafeTabsView()
    }
}
