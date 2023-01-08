//
//  AppState.swift
//  All About Olaf X
//
//  Created by Drew Volz on 8/3/20.
//

import SwiftUI

class AppState: ObservableObject {
    // MARK: keys

    static var darkMode = "isDarkModeEnabled"
    static var cafeSearch = "showScopeForCafeSearch"
    static var lowPowerEnabled = "isLowPowerEnabled"
    static var allTiles = "showInactiveHomeTiles"

    // MARK: general settings

    @Published var isDarkModeEnabled = UserDefaults.standard.bool(forKey: AppState.darkMode) {
        didSet {
            UserDefaults.standard.set(isDarkModeEnabled, forKey: AppState.darkMode)
        }
    }

    @Published var isLowPowerEnabled = UserDefaults.standard.bool(forKey: AppState.lowPowerEnabled) {
        didSet {
            UserDefaults.standard.set(isLowPowerEnabled, forKey: AppState.lowPowerEnabled)
        }
    }

    // MARK: debug + feature flags

    @Published var showScopeForCafeSearch = UserDefaults.standard.bool(forKey: AppState.cafeSearch) {
        didSet {
            UserDefaults.standard.set(showScopeForCafeSearch, forKey: AppState.cafeSearch)
        }
    }

    @Published var showInactiveHomeTiles = UserDefaults.standard.bool(forKey: AppState.allTiles) {
        didSet {
            UserDefaults.standard.set(showInactiveHomeTiles, forKey: AppState.allTiles)
        }
    }

    // MARK: json

    static var mockUserData: SearchUserResponse = load("user.json")
    static var dictionaryData: DictionaryResponse = load("dictionary.json")

    static func load<T: Decodable>(_ filename: String, as _: T.Type = T.self) -> T {
        let data: Data

        guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
        else {
            fatalError("Couldn't find \(filename) in main bundle.")
        }

        do {
            data = try Data(contentsOf: file)
        } catch {
            fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
        }

        do {
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: data)
        } catch {
            fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
        }
    }
}
