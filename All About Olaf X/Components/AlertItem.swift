//
//  AlertItem.swift
//  All About Olaf X
//
//  Created by Drew Volz on 8/20/20.
//

import SwiftUI

struct AlertItem: Identifiable {
    var id = UUID()
    var title: Text
    var message: Text
    var primaryButton: Alert.Button
    var secondaryButton: Alert.Button
}

func makeAlertItem(view: Component, openURL: OpenURLAction) -> AlertItem {
    AlertItem(title: Text("Open \(view.title) and leave \(UIApplication.bundleName)?"),
              message: Text("A web page will be opened in a browser outside of \(UIApplication.bundleName)."),
              primaryButton: .default(Text("Open")) {
                openURL(URL(string: view.url!)!)
              },
              secondaryButton: .cancel())
}
