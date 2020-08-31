//
//  InternalSettings.swift
//  Bon Appetit
//
//  Created by Drew Volz on 8/3/20.
//

import SwiftUI

struct InternalSettings: View {
    @EnvironmentObject var appState: AppState

    private var settingsList: [Setting] {
        [
            Setting(title: "Show inactive home tiles",
                            detail: "Makes it easier to tell which features exist",
                            state: $appState.showInactiveHomeTiles),

            Setting(title: "Show scope for cafe search",
                            detail: "Enables filtering for northfield cafes",
                            state: $appState.showScopeForCafeSearch)
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
        .navigationTitle("Feature flags")
    }
}

struct InternalSettings_Previews: PreviewProvider {
    static var previews: some View {
        InternalSettings()
    }
}
