//
//  SearchUserDetailView.swift
//  All About Olaf X
//
//  Created by Drew Volz on 8/24/20.
//

import SwiftUI

struct SearchUserDetailView: View {
    var user: SearchUser
    
    init(user: SearchUser) {
        self.user = user
        
        UITableView.appearance().backgroundColor = UIColor(named: "GroupedListBackground")
    }
    
    enum SubviewType {
        case empty
        case map
    }
    
    struct Row: View {
        @State var label: String = ""
        @State var description: String = ""
        @State var subviewType: SubviewType = .empty
        
        var body: some View {
            // opt to place our own label instead of using the groupbox's placement
            // since we would like to only provide one groupBoxStyle
            GroupBox(label: EmptyView(),
                     content: {
                        DescriptionView(label: label,
                                        value: description.stringByDecodingHTMLEntities,
                                        subviewType: subviewType)
                     })
                .groupBoxStyle(CustomGroupBoxStyle())
                .padding(.horizontal, 8)
                .padding(.vertical, 16)
        }
    }
    
    struct CustomGroupBoxStyle: GroupBoxStyle {
        func makeBody(configuration: Configuration) -> some View {
            configuration.content
                .padding(14)
                .background(Color(UIColor.secondarySystemGroupedBackground))
                .cornerRadius(10.0)
        }
    }
    
    struct DescriptionView: View {
        @State var label: String
        @State var value: String
        @State var subviewType: SubviewType
        
        var Content: some View {
            VStack(spacing: 3) {
                WrappedTextView(text: $label)
                    .font(.system(.footnote))
                
                WrappedTextView(text: $value)
                    .autoDetectDataTypes(.all)
                    .font(.system(.callout))
            }
        }
        
        var StandardDescriptionView: some View {
            Content
        }
        
        var MapDescriptionView: some View {
            HStack(alignment: .top) {
                Content
                MapThumbnail(address: value)
            }
        }
        
        var body: some View {
            switch subviewType {
            case .empty: StandardDescriptionView
            case .map: MapDescriptionView
            }
        }
    }
    
    struct OfficeView: View {
        private var location: SearchUser.CampusLocation
        private var label: String
        private var officePhone: String
        
        init(location: SearchUser.CampusLocation) {
            self.location = location
            self.officePhone = location.phone.isEmpty ? "no phone number listed" : location.phone
            self.label = location.display.isEmpty ? "office" : location.display
        }
        
        var body: some View {
            Row(label: label, description: officePhone)
        }
    }
    
    struct ContactHeader: View {
        @State var user: SearchUser
        @State var showTitle: Bool

        var body: some View {
            VStack {
                UrlImageView(urlString: user.thumbnail.absoluteString,
                                 imageFrame: CGSize(width: 85, height: 85))
                        .shadow(color: Color(.systemGray), radius: 1)
                    
                    if let displayName = $user.displayName {
                        WrappedTextView(text: displayName)
                            .multilineTextAlignment(.center)
                            .font(.system(.title1))
                    }
                    
                    if let displayTitle = $user.displayTitle.unwrap(), showTitle {
                        WrappedTextView(text: displayTitle)
                            .multilineTextAlignment(.center)
                            .font(.system(.subheadline))
                    }
            }
            .padding(20)
            .background(Color.clear)
        }
    }
    
    struct OuterView: View {
        var user: SearchUser
        
        var hasShortTitle: Bool {
            user.displayTitle?.count ?? 0 < 100
        }
        
        var body: some View {
            List {
                Section(header: HStack(alignment: .center) {
                    ContactHeader(user: user, showTitle: hasShortTitle)
                }){
                    VStack(spacing: -16) {
                        if let title = user.displayTitle, !title.isEmpty, !hasShortTitle {
                            Row(label: "title", description: title)
                        }
                        
                        if let specialties = user.specialties, !specialties.isEmpty {
                            Row(label: "specialties", description: specialties)
                        }
                        
                        if let locations = user.campusLocations, locations.count > 0 {
                            ForEach(locations, id:\.self) { location in
                                OfficeView(location: location)
                            }
                        }
                        
                        if let email = user.email, !email.isEmpty {
                            Row(label: "email", description: email)
                        }
                        
                        if let profile = user.profileUrl, !profile.absoluteString.isEmpty {
                            Row(label: "profile", description: profile.absoluteString)
                        }

                        if let addr = user.homeAddress, !addr.city.isEmpty {
                            // todo: previews really doesn't like this for some reason and crashes
//                            let address =
//                            """
//                            \(addr.street.joined(separator: ""))
//                            \(addr.city) \(addr.state) \(addr.zip)
//                            """
                            
                            let address = "Northfield MN"

                            Row(label: "home", description: address, subviewType: .map)
                        }
                        
                        if let notes = user.officeHours?.display, !notes.isEmpty {
                            Row(label: "Notes", description: notes)
                        }
                    }
                }
                .listRowInsets(EdgeInsets(.zero))
                .background(Color("GroupedListBackground"))
            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    var body: some View {
        OuterView(user: user)
    }
}

struct SearchUserDetail_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationView {
                SearchUserDetailView(user: AppState.mockUserData.results[0])
            }
            
            NavigationView {
                SearchUserDetailView(user: AppState.mockUserData.results[0])
            }
            .preferredColorScheme(.dark)
        }
    }
}

