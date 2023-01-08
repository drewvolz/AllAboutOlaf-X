//
//  App.swift
//  All About Olaf X
//
//  Created by Drew Volz on 8/2/20.
//

import SwiftUI

@main
struct MainApp: App {
    let appState = AppState()

    var body: some Scene {
        WindowGroup {
            Navigation().environmentObject(appState)
        }
    }
}

extension UINavigationController {
    override open func viewDidLoad() {
        super.viewDidLoad()

        configureNavbar()
    }

    private func configureNavbar() {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = UIColor(named: "NavbarBackground")
        appearance.backgroundEffect = UIBlurEffect(style: .systemUltraThinMaterial)

        UINavigationBar.appearance().compactAppearance = appearance
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance

        UINavigationBar.appearance().isTranslucent = true
    }
}
