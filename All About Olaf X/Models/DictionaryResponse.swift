//
//  Dictionary.swift
//  Bon Appetit
//
//  Created by Drew Volz on 8/16/20.
//

import Foundation
import SwiftUI

struct DictionaryResponse: Decodable {
    var data: [Term]
}

struct Term: Hashable, Identifiable, Decodable {
    enum CodingKeys: String, CodingKey {
        case id = "word"
        case definition
    }

    var id: String
    var definition: String
}
