//
//  Setting.swift
//  All About Olaf X
//
//  Created by Drew Volz on 8/17/20.
//

import SwiftUI

struct Setting: Identifiable {
    var id = UUID()
    var title: String
    var detail: String?
    var state: Binding<Bool>
}

struct SettingsRow: View {
    var setting: Setting

    var body: some View {
        VStack(alignment: .leading, spacing: 3) {
            Text(setting.title).font(.body)

            if let detail = setting.detail {
                Text(detail).font(.caption)
            }
        }
    }
}

struct SettingsRow_Previews: PreviewProvider {
    static var previews: some View {
        let fakeSetting = Setting(title: "This is a setting",
                                  detail: "More info about it",
                                  state: .constant(true))
        SettingsRow(setting: fakeSetting)
    }
}
