//
//  Actions.swift
//  All About Olaf X
//
//  Created by Drew Volz on 8/19/20.
//

import SwiftUI

struct ActionShareSheet: View {
    var type: ActionType
    var label: String?

    enum ActionType {
        case text
        case link
    }

    var body: some View {
        switch type {
        case .text: ActivityView(activityItems: [label ?? ""] as [String], applicationActivities: nil)
        case .link: ActivityView(activityItems: [URL(string: label ?? "")!], applicationActivities: nil)
        }
    }
}

struct ActionMenu: View {
    @State var label: String
    @State var actions: [ActionType]
    @Binding var showingSheet: Bool

    var pasteboard = UIPasteboard.general

    enum ActionType {
        case copy
        case share
    }

    var CopyButton: some View {
        ContextButton(label: "Copy", icon: .docOnDoc, action: {
            pasteboard.string = label
        })
    }

    var ShareButton: some View {
        ContextButton(label: "Share", icon: .squareAndUpArrow, action: {
            self.showingSheet.toggle()
        })
    }

    struct ContextButton: View {
        var label: String
        var icon: SFSymbol
        var action: () -> Void

        var body: some View {
            Button(action: {
                action()
            }) {
                HStack {
                    Text(label)
                    Image(symbol: icon)
                }
            }
        }
    }

    var body: some View {
        ForEach(actions, id: \.self) { action in
            switch action {
            case .copy: CopyButton
            case .share: ShareButton
            }
        }
    }
}

struct ActionMenu_Previews: PreviewProvider {
    static let fact = "Antarctica is the only continent with no owls."
    static let urlString = "https://en.wikipedia.org/wiki/Antarctica"

    static var ShareTextButton: some View {
        Button(action: {}, label: {
            Text("Text options")
        })
        .contextMenu {
            ActionMenu(label: fact, actions: [.copy, .share], showingSheet: .constant(false))
        }
        .sheet(isPresented: .constant(false), content: {
            ActionShareSheet(type: .text, label: fact)
        })
    }

    static var ShareLinkButton: some View {
        Button(action: {}, label: {
            Text("Link options")
        })
        .contextMenu {
            ActionMenu(label: fact, actions: [.share], showingSheet: .constant(false))
        }
        .sheet(isPresented: .constant(false), content: {
            ActionShareSheet(type: .link, label: urlString)
        })
    }

    static var previews: some View {
        List {
            Section(header: Text("Context menus and sheets"),
                    footer: Text("The share menu will not popup. Change showingSheet to true to view it without interaction.")) {
                ShareTextButton
                ShareLinkButton
            }
        }
        .insetGroupedStyle()
    }
}
