//
//  ContactDetailViewModel.swift
//  AllAboutOlafX
//
//  Created by Drew Volz on 10/29/19.
//  Copyright © 2019 Drew Volz. All rights reserved.
//

import ContactsUI
import Combine

final class ContactDetailViewModel: ObservableObject {
    private(set) var viewmodel: SearchUserViewModel
    private(set) var user: SearchUser

    init(searchViewModel: SearchUserViewModel, searchUser: SearchUser) {
        viewmodel = searchViewModel
        user = searchUser
    }

    public func createContact() -> CNMutableContact {
        let contact = CNMutableContact()

        if let photo = createImageData() as Data? {
            contact.imageData = photo
        }

        if let givenName = user.firstName as String? {
            contact.givenName = givenName
        }

        if let familyName = user.lastName as String? {
            contact.familyName = familyName
        }

        if let nameSuffix = user.suffixName as String? {
            contact.nameSuffix = nameSuffix
        }

        if let jobTitle = createJobTitle() as String? {
            contact.jobTitle = jobTitle
        }

        if user.departments != nil, (user.departments?.first?.name as String?) != nil {
            contact.departmentName = createDepartments()
        }

        if let emailAddresses = createEmailAddresses() as [CNLabeledValue<NSString>]? {
            contact.emailAddresses = emailAddresses
        }

        if let phoneNumbers = createPhoneNumbers() as [CNLabeledValue<CNPhoneNumber>]? {
            contact.phoneNumbers = phoneNumbers
        }

        if let postalAddresses = createPostalAddress() as [CNLabeledValue<CNPostalAddress>]? {
            contact.postalAddresses = postalAddresses
        }

        if user.profileUrl?.absoluteString != nil {
            if let urlAddresses = createUrlAddresses() as [CNLabeledValue<NSString>]? {
                contact.urlAddresses = urlAddresses
            }
        }

        if let officeHours = createOfficeHours() as String? {
            contact.note = officeHours
        }

        return contact
    }

    func createDepartments() -> String {
        user.departments?.map { $0.name }.joined(separator: ", ") ?? ""
    }

    func createJobTitle() -> String {
        if let displayTitle = user.displayTitle {
            return displayTitle.stringByDecodingHTMLEntities
        }

        return ""
    }

    func createEmailAddresses() -> [CNLabeledValue<NSString>] {
        [CNLabeledValue(label: "email", value: NSString(string: user.email))]
    }

    func createImageData() -> Data? {
        let cachedImageView = UrlImageView(urlString: user.thumbnail.absoluteString)
        return cachedImageView.urlImageModel.image?.pngData()
    }

    func createOfficeHours() -> String {
        user.officeHours?.display?.stringByDecodingHTMLEntities ?? ""
    }

    func createPhoneNumbers() -> [CNLabeledValue<CNPhoneNumber>] {
        var phoneNumbers: [CNLabeledValue<CNPhoneNumber>] = []

        user.campusLocations?.forEach { location in
            let shortLabel = "\(location.buildingabbr) \(location.room)"
            let label = shortLabel.trimmingCharacters(in: .whitespaces).isEmpty ? "office" : shortLabel
            let officePhone = CNLabeledValue(label: label, value: CNPhoneNumber(stringValue: location.phone))
            phoneNumbers.append(officePhone)
        }

        if user.homePhone?.trimmingCharacters(in: .whitespaces).isEmpty == false {
            let homePhone = CNLabeledValue(label: CNLabelHome, value: CNPhoneNumber(stringValue: user.homePhone ?? ""))
            phoneNumbers.append(homePhone)
        }
        return phoneNumbers
    }

    func createPostalAddress() -> [CNLabeledValue<CNPostalAddress>] {
        var addresses: [CNLabeledValue<CNPostalAddress>] = []

        let addr = CNMutablePostalAddress()
        addr.street = user.homeAddress?.street.joined() ?? ""
        addr.city = user.homeAddress?.city ?? ""
        addr.state = user.homeAddress?.state ?? ""
        addr.postalCode = user.homeAddress?.zip ?? ""
        addr.country = user.homeAddress?.country ?? ""

        if addr.street.isEmpty == false ||
            addr.city.isEmpty == false ||
            addr.state.isEmpty == false ||
            addr.postalCode.isEmpty == false ||
            addr.country.isEmpty == false {
            let immuatableAddr: CNPostalAddress = addr.copy() as? CNPostalAddress ?? CNPostalAddress()
            let address = CNLabeledValue(label: "home address", value: immuatableAddr)
            addresses.append(address)
        }
        return addresses
    }

    func createUrlAddresses() -> [CNLabeledValue<NSString>] {
        let profile = user.profileUrl?.absoluteString as NSString? ?? ""
        return [CNLabeledValue(label: CNLabelURLAddressHomePage, value: profile)]
    }
}
