//
//  SentSection.swift
//  
//
//  Created by Mikhail Borisov on 13.03.2022.
//

import SwiftUI
import Core
import DesignSystem

struct ActionSection: View {

    let isIncoming: Bool

    init(isIncoming: Bool) {
        self.isIncoming = isIncoming
    }

    var body: some View {
        VStack(alignment: .center, spacing: 10.0) {
            Button(
                isIncoming
                ? StringFactory.Details.donate.localizableString
                : StringFactory.Details.cancel.localizableString
            ) {
                print("here")
            }
            .buttonStyle(BrandButtonStyle(color: isIncoming ? .brand : .magnetta))
            HStack(alignment: .center) {
                Text("Совершая перевод, вы соглшаетесь \nс [пользовательским соглашением](https://apple.com).")
                    .font(.footnote)
                    .onTapGesture {
                        print("Agreement click")
                    }
            }
        }
        .listRowSeparator(.hidden)
    }
}
