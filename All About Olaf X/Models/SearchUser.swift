//
//  SearchUser.swift
//  Bon Appetit
//
//  Created by Drew Volz on 8/17/20.
//

import Foundation
import SwiftUI

public struct SearchUserResponse: Encodable, Decodable {
    var results: [SearchUser]
}

struct SearchUser: Hashable, Identifiable, Encodable, Decodable {
    enum CodingKeys: String, CodingKey {
        case id = "username"
        case displayName
        case classYear
        case suffixName
        case firstName
        case thumbnail
        case homePhone
        case email
        case departments
        case onLeave
        case homeAddress
        case pronouns
        case lastName
        case profileUrl
        case campusLocations
        case title
        case photo
        case officeHours
        case displayTitle
        case specialties
    }

    struct Department: Encodable, Decodable, Hashable {
        struct QueryDepartmentOrMajor: Encodable, Decodable, Hashable {
            var department: String?
            var major: String?
        }

        var query: QueryDepartmentOrMajor
        var href: URL
        var name: String
    }

    struct HomeAddress: Encodable, Decodable, Hashable {
        var zip: String
        var city: String
        var country: String
        var state: String
        var street: [String]
    }

    struct CampusLocation: Encodable, Decodable, Hashable {
        var display: String
        var buildingabbr: String
        var building: String
        var phone: String
        var room: String
    }

    struct OfficeHours: Encodable, Decodable, Hashable {
        var display: String?
        var prefix: String?
        var hrefLabel: String?
        var href: String?
        var content: String?
    }

    struct OnLeave: Encodable, Decodable, Hashable {
        var start: String?
        var end: String?
        var type: String?
    }

    // TODO: check if these are correct for value and optionality
    var id: String
    var displayName: String
    var classYear: String?
    var suffixName: String?
    var firstName: String
    var thumbnail: URL
    var homePhone: String?
    var email: String
    var departments: [Department]?
    var onLeave: OnLeave?
    var homeAddress: HomeAddress?
    var pronouns: [String]?
    var lastName: String
    var profileUrl: URL?
    var campusLocations: [CampusLocation]?
    var title: String?
    var photo: URL
    var officeHours: OfficeHours?
    var displayTitle: String?
    var specialties: String?
}
