//
//  ContentView.swift
//  All About Olaf X
//
//  Created by Drew Volz on 8/2/20.
//

import SwiftUI

struct FilterView: View {
    @ObservedObject var searchViewModel = CafeListViewModel()
    @ObservedObject var menuViewModel = MenuListViewModel()

    @State var recent = ["Rice", "Chicken", "Gyoza"]
    @State var restrictions = ["Vegetarian", "Seafood Watch", "Vegan", "Made without Gluten"]
    @State var stations = ["Tortilla", "Pasta", "Grains", "Bowls", "Home"]

    struct Row: View {
        @State var imageName: SFSymbol
        @State var text = ""

        var body: some View {
            HStack {
                Image(symbol: imageName)
                Text(text)
            }
        }
    }

    var body: some View {
            List {
                Section(header: Text("Recent Searches")) {
                    ForEach(recent, id: \.self) { data in
                        Row(imageName: .magnifyingGlass, text: data)
                    }
                }

                Section(header: Text("Dietary Restrictions")) {
                    ForEach(restrictions, id: \.self) { data in
                        Row(imageName: .heart, text: data)
                    }
                }

                Section(header: Text("Stations")) {
                    ForEach(stations, id: \.self) { data in
                        Row(imageName: .lineH3DecreaseCircle, text: data)
                    }
                }
            }
            .insetGroupedStyle()
    }
}

struct FilterView_Previews: PreviewProvider {
    static var previews: some View {
        FilterView()
    }
}
