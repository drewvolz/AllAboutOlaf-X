//
//  GeneralSettingsView.swift
//  Bon Appetit
//
//  Created by Drew Volz on 8/9/20.
//

import SwiftUI

struct GeneralSettingsView: View {
    @EnvironmentObject var appState: AppState

    private var settingsList: [Setting] {
        [
            Setting(title: "Dark mode", state: $appState.isDarkModeEnabled)
        ]
    }

    var body: some View {
        List {
            ForEach(settingsList) { setting in
                Toggle(isOn: setting.state) {
                    SettingsRow(setting: setting)
                }
            }
        }
        .insetGroupedStyle()
        .navigationTitle("Appearance")
    }
}

struct GeneralSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        GeneralSettingsView()
    }
}
