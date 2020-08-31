//
//  App.swift
//  Bon Appetit
//
//  Created by Drew Volz on 8/2/20.
//

import SwiftUI

@main
class BonApp: App {
    let appState = AppState()

    required init() {
        addObservers()
    }

    // todo: check if this is the right way to do this
    deinit {
        removeObservers()
    }

    private func addObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(powerStateChanged),
                                               name: Notification.Name.NSProcessInfoPowerStateDidChange, object: nil)
    }

    private func removeObservers() {
        NotificationCenter.default.removeObserver(self,
                                                  name: Notification.Name.NSProcessInfoPowerStateDidChange, object: nil)
    }

    @objc private func powerStateChanged(_ notification: Notification) {
        appState.isLowPowerEnabled = ProcessInfo.processInfo.isLowPowerModeEnabled
    }

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
