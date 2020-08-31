//
//  NewsResponse.swift
//  Bon Appetit
//
//  Created by Drew Volz on 8/17/20.
//

import SwiftUI

public struct NewsResponse: Hashable, Identifiable, Encodable, Decodable {
    enum CodingKeys: String, CodingKey {
        case title
        case excerpt
        case featuredImage
        case link
    }

    public var id = UUID()
    var title: String
    var excerpt: String
    var featuredImage: String?
    var link: String?
}
