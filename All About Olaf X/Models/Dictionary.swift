//
//  Dictionary.swift
//  AllAboutOlafX
//
//  Created by Drew Volz on 10/30/19.
//  Copyright © 2019 Drew Volz. All rights reserved.
//

import Foundation
import SwiftUI

struct DictionaryResponse: Decodable {
    var data: [Term]
}

struct Term: Hashable, Identifiable, Decodable {
    enum CodingKeys: String, CodingKey {
        case word
        case definition
    }

    var id = UUID()
    var word: String
    var definition: String
}
