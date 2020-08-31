//
//  Orgs.swift
//  Bon Appetit
//
//  Created by Drew Volz on 8/18/20.
//

import Foundation
import SwiftUI

public struct Org: Hashable, Identifiable, Encodable, Decodable {
    enum CodingKeys: String, CodingKey {
        case category
        case description
        case lastUpdated
        case meetings
        case name
        case website
        case sortableName = "$sortableName"
        case groupableName = "$groupableName"
    }

    public var id = UUID()
    var category: String
    var description: String
    var lastUpdated: String
    var meetings: String
    var name: String
    var website: String
    var sortableName: String
    var groupableName: String
}
