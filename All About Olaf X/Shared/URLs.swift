//
//  Constants.swift
//  Bon Appetit
//
//  Created by Drew Volz on 8/3/20.
//

import Foundation

struct Urls {
    private struct Domains {
        struct BonAppetit {
            static let Base = "https://legacy.cafebonappetit.com"
        }

        struct GitHub {
            static let Base = "https://stolaf.dev"
        }

        struct Moodle {
            static let Base = "https://moodle.stolaf.edu"
        }

        struct StOlafWP {
            static let Base = "https://wp.stolaf.edu"
        }

        struct StOlaf {
            static let Base = "https://www.stolaf.edu"
        }

        struct CCCServer {
            static let Base = "https://stolaf.api.frogpond.tech"
        }
    }

    private static let BonAppURL = Domains.BonAppetit.Base + "/api/2"
    private static let CafesURL = Domains.GitHub.Base + "/BonApp-Widget"
    private static let MoodleURL = Domains.Moodle.Base
    private static let SafetyURL = Domains.StOlafWP.Base + "/safety-committee"
    private static let DirectoryURL = Domains.StOlaf.Base + "/directory"
    private static let CCCURL = Domains.CCCServer.Base + "/v1"

    struct api {
        static var menus: String {
            return BonAppURL + "/menus"
        }

        static var cafesList: String {
            return CafesURL + "/scripts/data.json"
        }

        static var cccnews: String {
            return CCCURL + "/news/named/"
        }

        static var directory: String {
            return DirectoryURL + "/index.cfm"
        }

        static var orgs: String {
            return CCCURL + "/orgs"
        }
    }

    struct home {
        static var moodle: String {
            return MoodleURL
        }

        static var safety: String {
            return SafetyURL + "/report/"
        }
    }
}
