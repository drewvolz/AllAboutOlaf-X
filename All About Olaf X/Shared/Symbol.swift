//
//  Symbol.swift
//  All About Olaf X
//
//  Created by Drew Volz on 8/21/20.
//

import SwiftUI

public enum SFSymbol: String, CaseIterable {
    case aClosedBook = "a.book.closed"
    case ant = "ant"
    case cCircleFill = "c.circle.fill"
    case chevronLeft = "chevron.left"
    case chevronRight = "chevron.right"
    case clock = "clock"
    case calendar = "calendar"
    case docOnDoc = "doc.on.doc"
    case exclamationmarkTriangle = "exclamationmark.triangle"
    case heart = "heart"
    case gear = "gear"
    case globe = "globe"
    case graduationCap = "graduationcap"
    case kCircleFill = "k.circle.fill"
    case lineH3DecreaseCircle = "line.horizontal.3.decrease.circle"
    case leaf = "leaf"
    case magnifyingGlass = "magnifyingglass"
    case map = "map"
    case mapPinCircleFill = "mappin.circle.fill"
    case mCircleFill = "m.circle.fill"
    case newspaper = "newspaper"
    case oCircleFill = "o.circle.fill"
    case pCircleFill = "p.circle.fill"
    case personCropCircle = "person.crop.circle"
    case phone = "phone"
    case printer = "printer"
    case questionMark = "questionmark"
    case sCircleFill = "s.circle.fill"
    case signpostRight = "signpost.right"
    case squareAndUpArrow = "square.and.arrow.up"
    case tagFill = "tag.fill"
    case tortoise = "tortoise"
    case touchId = "touchid"
    case umbrella = "umbrella"
    case video = "video"
}

extension Image {
    init(symbol: SFSymbol) {
        self.init(systemName: symbol.rawValue)
    }
}

extension UIImage {
    convenience init?(symbol: SFSymbol) {
        self.init(systemName: symbol.rawValue)
    }
}
