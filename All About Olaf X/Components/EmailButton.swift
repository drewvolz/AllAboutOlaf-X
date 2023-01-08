//
//  ComposeEmailModifier.swift
//  All About Olaf X
//
//  Created by Drew Volz on 8/7/20.
//

import SwiftUI
import MessageUI

struct EmailButton: View {
    @State var result: Result<MFMailComposeResult, Error>?
    @State var isShowingMailView = false
    @State var alertNoMail = false

    var title: String
    var icon: SFSymbol?
    var to: String
    var subject: String
    var content: String

    init(title: String, icon: SFSymbol? = nil, to: String, subject: String, content: String) {
        self.title = title
        self.icon = icon
        self.to = to
        self.subject = subject
        self.content = content
    }

    var body: some View {
        ComposeButton()
            .sheet(isPresented: $isShowingMailView) {
                MailView(result: self.$result, to: to, subject: subject, body: content)
            }
            .alert(isPresented: self.$alertNoMail) {
                Alert(title: Text("This device is unable to compose emails."))
            }
    }

    @ViewBuilder func ComposeButton() -> some View {
        HStack {
            if icon != nil {
                Image(symbol: icon!)
            }

            Button(action: onButtonTap) {
                Text(title)
            }
            .buttonStyle(DefaultButtonStyle())
        }
    }

    private func onButtonTap() {
        if MFMailComposeViewController.canSendMail() {
            self.isShowingMailView.toggle()
        } else {
            self.alertNoMail.toggle()
        }
    }
}
