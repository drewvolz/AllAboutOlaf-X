//
//  AcctivityView.swift
//  All About Olaf X
//
//  Created by Drew Volz on 8/19/20.
//

import SwiftUI

struct ActivityView: UIViewControllerRepresentable {
    let activityItems: [Any]
    let applicationActivities: [UIActivity]?

    func makeUIViewController(context _: UIViewControllerRepresentableContext<ActivityView>) -> UIActivityViewController {
        return UIActivityViewController(activityItems: activityItems,
                                        applicationActivities: applicationActivities)
    }

    func updateUIViewController(_: UIActivityViewController,
                                context _: UIViewControllerRepresentableContext<ActivityView>) {}
}
