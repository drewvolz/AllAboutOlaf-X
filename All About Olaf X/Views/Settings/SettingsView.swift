//
//  SettingsView.swift
//  All About Olaf X
//
//  Created by Drew Volz on 8/3/20.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var appState: AppState
    @Binding var showingSettings: Bool

    fileprivate let support = Support()

    struct Support {
        let to = "support@terrapin.studio"
        let subject = "Support: \(UIApplication.bundleName)"
        let body = """
            Idea? Question? Comment? Concern? Let us know.

            ----- Please do not edit below here -----
            \(UIApplication.friendlyVersion)
            """
    }

    func DebugView() -> some View {
        Section(header: HStack {
            Image(symbol: .ant)
            Text("Internal")
        }) {
            NavigationLink(
                destination: InternalSettings(),
                label: {
                    Text("Feature flags")
                })
        }
    }

    func GeneralView() -> some View {
        Section(
            header: HStack {
                Image(symbol: .umbrella)
                Text("General")
            }) {
            NavigationLink(
                destination: GeneralSettingsView(),
                label: {
                    Text("Appearance")
                }
            )

            Button("Open \(UIApplication.bundleName) settings", action: openSettings)
        }
    }

    func AboutView() -> some View {
        Section(
            header: HStack {
                Image(symbol: .tortoise)
                Text("About")
            },
            footer: HStack {
                Spacer()
                Text("Built with ❤️ by Terrapin Studio")
                Spacer()
            }
        ) {
            HStack {
                Text("Version")
                Spacer()
                Text(UIApplication.friendlyVersion)
            }

            EmailButton(title: "Contact support",
                        to: support.to,
                        subject: support.subject,
                        content: support.body)
        }
    }

    private func openSettings() {
        guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
            return
        }

        if UIApplication.shared.canOpenURL(settingsUrl) {
            UIApplication.shared.open(settingsUrl, completionHandler: nil)
        }
    }

    @ViewBuilder func DoneButton() -> some View {
        Button(action: {
            self.showingSettings.toggle()
        }) {
            Text("Done")
        }
        .buttonStyle(PlainButtonStyle())
    }

    var body: some View {
        NavigationView {
            List {
                #if DEBUG
                DebugView()
                #endif

                GeneralView()

                AboutView()
            }
            .insetGroupedStyle()
            .font(Font.system(.body))
            .navigationBarTitle("Settings", displayMode: .inline)
            .navigationBarItems(trailing: DoneButton())
            .preferredColorScheme(appState.isDarkModeEnabled ? .dark : .light)
        }
    }
}

//struct SettingsView_Previews: PreviewProvider {
//    @State var showingSettings: Bool = true
//
//    static var previews: some View {
//        SettingsView( showingSettings: $showingSettings)
//    }
//}
