//
// ExpirationRow.swift
//  
//
//  Created by Mikhail Borisov on 20.03.2022.
//

import SwiftUI
import DesignSystem
import Core

struct ExpirationRow: View {

    @Binding var expirationDateValue: Double?

    @State var expirationString: String = ""
    @State var isSelected: Bool = false

    var body: some View {
        VStack(alignment: .leading) {
            InputField(StringFactory.Add.fundExpiration.localizableString, text: $expirationString)
            Chips(title: StringFactory.Add.without.localizableString, binding: $isSelected)
        }.onChange(of: isSelected, perform: { newValue in
            expirationString = newValue ? "Без срока" : (expirationDateValue ?? 0).debugDescription
            expirationDateValue = newValue ? nil : 12344434
        })
        .padding([.leading, .trailing, .top])
    }
}
