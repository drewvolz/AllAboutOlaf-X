//
//  OrgDetail.swift
//  Bon Appetit
//
//  Created by Drew Volz on 8/18/20.
//

import SwiftUI

struct OrgDetail: View {
    @State var org: Org

    struct OrgRow: View {
        @State var title: String?
        @State var description: String
        @State var viewTitle: Bool?
        @State var showingSheet: Bool = false

        var font: UIFont {
            viewTitle == true ? .system(.title1) : .system(.body)
        }

        @ViewBuilder private var Header: some View {
            if let title = title {
                Text(title)
            }
        }

        var body: some View {
            Section(header: Header) {
                WrappedTextView(text: $description)
                .font(font)
            }
        }
    }

    var body: some View {
        List {
            OrgRow(description: org.name, viewTitle: true)

            if !org.category.isEmpty {
                OrgRow(title: "Category", description: org.category)
            }

            if !org.meetings.isEmpty {
                OrgRow(title: "Meetings", description: org.meetings)

            }

            if !org.description.isEmpty {
                OrgRow(title: "Description", description: org.description)
            }
        }
        .insetGroupedStyle()
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct OrgDetail_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            OrgDetail(org: Org(category: "Academic",
                               description: "Computers! Computers! Computers!",
                               lastUpdated: "2000-01-01",
                               meetings: "RNS 204 Monday's 3 - 4 pm",
                               name: "Algorithms Club at St. Olaf College",
                               website: "https://stolaf.edu",
                               sortableName: "algorithms club at st. olaf college",
                               groupableName: "A"))
        }
    }
}
