//
//  Views.swift
//  All About Olaf X
//
//  Created by Drew Volz on 8/15/20.
//

import SwiftUI

enum ComponentType {
    case url
    case view
}

enum NavigationItem {
    case menus
    case sis
    case buildingHours
    case calendar
    case directory
    case streamingMedia
    case news
    case campusMap
    case importantContacts
    case transportation
    case campusDictionary
    case studentOrgs
    case moodle
    case reportProblem
    case stoPrint
    case safetyConcerns
}

struct Component: Identifiable {
    var id: NavigationItem
    var title: String
    var icon: SFSymbol
    var destination: AnyView
    var type: ComponentType
    var url: String?
    var tint: Color
    var active: Bool?

    init<V: View>(id: NavigationItem, title: String, icon: SFSymbol, destination: V, type: ComponentType, url: String? = "", tint: Color, active: Bool? = false) {
        self.id = id
        self.title = title
        self.icon = icon
        self.destination = AnyView(destination)
        self.type = type
        self.url = url
        self.tint = tint
        self.active = active
    }
}

struct Components {
    static var views = [
        Component(id: .menus,
                  title: "Menus",
                  icon: .leaf,
                  destination: CafeTabsView(),
                  type: .view,
                  tint: .green,
                  active: true),

        Component(id: .sis,
                  title: "SIS",
                  icon: .touchId,
                  destination: EmptyView(),
                  type: .view,
                  tint: .orange),

        Component(id: .buildingHours,
            title: "Building Hours",
                  icon: .clock,
                  destination: EmptyView(),
                  type: .view,
                  tint: .purple),

        Component(id: .calendar,
            title: "Calendar",
            icon: .calendar,
                  destination: EmptyView(),
                  type: .view,
                  tint: .red),

        Component(id: .directory,
            title: "Directory",
            icon: .personCropCircle,
                  destination: SearchUserView(),
                  type: .view,
                  tint: .red,
                  active: true),

        Component(id: .streamingMedia,
            title: "Streaming Media",
            icon: .video,
                  destination: EmptyView(),
                  type: .view,
                  tint: .blue),

        Component(id: .news,
                    title: "News",
                    icon: .newspaper,
                  destination: NewsTabs(),
                  type: .view,
                  tint: .blue,
                  active: true),

        Component(id: .campusMap,
            title: "Campus Map",
            icon: .map,
                  destination: EmptyView(),
                  type: .view,
                  tint: .purple),

        Component(id: .importantContacts,
            title: "Important Contacts",
            icon: .phone,
                  destination: EmptyView(),
                  type: .view,
                  tint: .red),

        Component(id: .transportation,
            title: "Transportation",
            icon: .signpostRight,
                  destination: EmptyView(),
                  type: .view,
                  tint: Color.green.opacity(0.7)),

        Component(id: .campusDictionary,
            title: "Campus Dictionary",
            icon: .aClosedBook,
                  destination: DictionaryList(),
                  type: .view,
                  tint: .gray,
                  active: true),

        Component(id: .studentOrgs,
            title: "Student Orgs",
            icon: .globe,
                  destination: OrgList(),
                  type: .view,
                  tint: .black,
                  active: true),

        Component(id: .moodle,
            title: "Moodle",
            icon: .graduationCap,
                  destination: EmptyView(),
                  type: .url,
                  url: Urls.home.moodle,
                  tint: .orange,
                  active: true),

        Component(id: .reportProblem,
                  title: "Report A Problem",
                  icon: .questionMark,
                  destination: EmptyView(),
                  type: .view,
                  tint: .blue),

        Component(id: .stoPrint,
                  title: "stoPrint",
                  icon: .printer,
                  destination: EmptyView(),
                  type: .view,
                  tint: .green),

        Component(id: .safetyConcerns,
                  title: "Safety Concerns",
                  icon: .exclamationmarkTriangle,
                  destination: EmptyView(),
                  type: .url,
                  url: Urls.home.safety,
                  tint: .orange,
                  active: true)
    ]
}
