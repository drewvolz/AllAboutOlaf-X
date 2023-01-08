//
//  NewsTabs.swift
//  All About Olaf X
//
//  Created by Drew Volz on 8/17/20.
//

import SwiftUI

struct NewsTabs: View {
    @State private var selection: Tab = .olaf

    enum Tab {
        case olaf
        case mess
        case oleville
        case politicole
        case ksto
    }

    let olaf = "St. Olaf"
    let mess = "The Mess"
    let oleville = "Oleville"
    let politicole = "PoliticOle"
    let ksto = "KSTO"

    var body: some View {
        TabView(selection: $selection) {
            NewsFeed(named: "stolaf")
                .tabItem {
                    Label.init(olaf, systemImage: SFSymbol.oCircleFill.rawValue)
                        .accessibility(label: Text(olaf))
                }
                .tag(Tab.olaf)

            NewsFeed(named: "mess")
                .tabItem {
                    Label(mess, systemImage: SFSymbol.mCircleFill.rawValue)
                        .accessibility(label: Text(mess))
                }
                .tag(Tab.mess)

            NewsFeed(named: "oleville")
                .tabItem {
                    Label(oleville, systemImage: SFSymbol.oCircleFill.rawValue)
                        .accessibility(label: Text(oleville))
                }
                .tag(Tab.oleville)

            NewsFeed(named: "politicole")
                .tabItem {
                    Label(politicole, systemImage: SFSymbol.pCircleFill.rawValue)
                        .accessibility(label: Text(politicole))
                }
                .tag(Tab.politicole)

            NewsFeed(named: "ksto")
                .tabItem {
                    Label(ksto, systemImage: SFSymbol.oCircleFill.rawValue)
                        .accessibility(label: Text(ksto))
                }
                .tag(Tab.ksto)
        }
        .navigationTitle("News")
    }
}

struct NewsTabs_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            NewsTabs()
        }
    }
}
