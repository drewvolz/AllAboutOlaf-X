//
//  CafeList.swift
//  Bon Appetit
//
//  Created by Drew Volz on 8/3/20.
//

import SwiftUI

public struct CafeListResponse: Hashable, Identifiable, Encodable, Decodable {
    enum CodingKeys: String, CodingKey {
        case id
        case label
        case desc
    }

    public var id: String
    var label: String
    var desc: String
}
