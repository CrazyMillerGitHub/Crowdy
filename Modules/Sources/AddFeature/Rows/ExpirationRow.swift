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

    @Binding var expirationDateValue: String
    @State var isSelected: Bool = true

    var body: some View {
        VStack(alignment: .leading) {
            InputField(placeholder: StringFactory.Add.fundExpiration.localizableString, binding: $expirationDateValue) {
                ToSwiftUI {
                    DatePickerTextField(placeholder: "", binding: $expirationDateValue, emptyTitle: StringFactory.Add.without.localizableString)
                }
                .disabled(isSelected)
            }
            Chips(title: StringFactory.Add.without.localizableString, binding: $isSelected)
        }
        .padding([.leading, .trailing, .top])
    }
}
