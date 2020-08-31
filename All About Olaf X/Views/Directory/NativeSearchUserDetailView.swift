//
//  NativeSearchUserDetailView.swift
//  AllAboutOlafX
//
//  Created by Drew Volz on 10/26/19.
//  Copyright © 2019 Drew Volz. All rights reserved.
//

import ContactsUI
import SwiftUI

struct NativeSearchUserDetailView: View {
    @ObservedObject var searchUserViewModel: SearchUserViewModel
    var user: SearchUser

    var body: some View {
        let contactViewModel = ContactDetailViewModel(searchViewModel: searchUserViewModel, searchUser: user)
        let contactVCWrapper = CNContactViewControllerWrapper(contactViewModel: contactViewModel)
        return contactVCWrapper
            .edgesIgnoringSafeArea(.bottom)
            .navigationBarTitleDisplayMode(.inline)
    }
}

struct CNContactViewControllerWrapper: UIViewControllerRepresentable {
    typealias UIViewControllerType = CNContactViewController

    @ObservedObject var contactViewModel: ContactDetailViewModel

    func makeUIViewController(context _: UIViewControllerRepresentableContext<CNContactViewControllerWrapper>) -> CNContactViewControllerWrapper.UIViewControllerType {
        let directoryContact = contactViewModel.createContact()

        let contactViewController = CNContactViewController(forUnknownContact: directoryContact)
        contactViewController.contactStore = nil
        contactViewController.allowsActions = false
        contactViewController.allowsEditing = false
        return contactViewController
    }

    func updateUIViewController(_: CNContactViewControllerWrapper.UIViewControllerType, context _: UIViewControllerRepresentableContext<CNContactViewControllerWrapper>) {}
}

struct SearchUserDetail_Preview: PreviewProvider {
    static var previews: some View {
        ForEach(["iPhone SE", "iPhone X", "iPhone XS Max"], id: \.self) { deviceName in
            Group {
                NavigationView {
                    NativeSearchUserDetailView(searchUserViewModel: SearchUserViewModel(), user: AppState.mockUserData.results[0])
                        .environment(\.colorScheme, .dark)
                        .environment(\.sizeCategory, .extraSmall)
                }

                NavigationView {
                    NativeSearchUserDetailView(searchUserViewModel: SearchUserViewModel(), user: AppState.mockUserData.results[0])
                        .environment(\.colorScheme, .light)
                        .environment(\.sizeCategory, .large)
                }

                NavigationView {
                    NativeSearchUserDetailView(searchUserViewModel: SearchUserViewModel(), user: AppState.mockUserData.results[0])
                        .environment(\.colorScheme, .dark)
                        .environment(\.sizeCategory, .accessibilityExtraExtraExtraLarge)
                }
            }
            .previewDevice(PreviewDevice(rawValue: deviceName))
            .previewDisplayName(deviceName)
        }
    }
}
