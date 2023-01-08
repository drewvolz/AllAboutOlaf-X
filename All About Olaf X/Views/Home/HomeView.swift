import SwiftUI

struct HomeView: View {
    @EnvironmentObject var appState: AppState
    @Environment(\.openURL) var openURL

    @State private var showingSettings: Bool = false
    @State private var alertItem: AlertItem?

    var body: some View {
        GeometryReader { geometry in
            let columns = calculateColumns(width: geometry.size.width)

            ScrollView {
                Spacer()
                LazyVGrid(columns: columns) {
                    ForEach(Components.views) { view in
                        if appState.showInactiveHomeTiles || view.active ?? false {
                            switch view.type {
                            case .view: ButtonView(view: view)
                            case .url: LinkView(view: view)
                            }
                        }
                    }
                }
            }
            .preferredColorScheme(appState.isDarkModeEnabled ? .dark : .light)
            .navigationBarItems(trailing: SettingsButton(showing: $showingSettings).environmentObject(appState))
            .navigationBarTitle(UIApplication.bundleName)
        }
    }
}

extension HomeView {
    // MARK: Config

    private func calculateColumns(width: CGFloat) -> [GridItem] {
        let width = (width / 2) - 20

        return [
            GridItem(.fixed(width)),
            GridItem(.fixed(width))
        ]
    }

    // MARK: Button URL alerts

    func LinkView(view: Component) -> some View {
        Button(action: {
            self.alertItem = makeAlertItem(view: view, openURL: openURL)
        }) {
            HomeTile(view: view)
        }
        .buttonStyle(PlainButtonStyle())
        .alert(item: $alertItem) { alertItem in
            Alert(title: alertItem.title,
                  message: alertItem.message,
                  primaryButton: alertItem.primaryButton,
                  secondaryButton: alertItem.secondaryButton
            )}
    }



    // MARK: Buttons

    func ButtonView(view: Component) -> some View {
        NavigationLink(destination: view.destination.environmentObject(self.appState)) {
            HomeTile(view: view)
        }
        .buttonStyle(PlainButtonStyle())
    }

    // MARK: GroupBox

    func HomeTile(view: Component) -> some View {
        GroupBox(label:
                    Image(symbol: view.icon)
                    .addCircle(foregroundColor: Color.white, backgroundColor: view.tint)
        ) {
            HomeTitleView(title: view.title)
        }
        .groupBoxStyle(HomeGroupBoxStyle(tint: view.tint))
    }

    struct HomeTitleView: View {
        var title: String

        @ScaledMetric var size: CGFloat = 1

        var body: some View {
            HStack {
                Text(title)
                    .font(.system(size: 13 * size, weight: .bold, design: .rounded))
                    .foregroundColor(.secondary)
                Spacer()
            }
        }
    }

    struct HomeGroupBoxStyle: GroupBoxStyle {
        var tint: Color

        @ScaledMetric var size: CGFloat = 1

        func makeBody(configuration: Configuration) -> some View {
            VStack {
                HStack {
                    configuration.label
                    Spacer()
                    Chevron(pointing: .right)
                }
                Spacer()
                configuration.content
                    .padding(.top, 5)
            }
            .padding(10)
            .background(Color("HomeTile"))
            .cornerRadius(15.0)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            HomeView()

            HomeView()
                .preferredColorScheme(.dark)
        }
    }
}
