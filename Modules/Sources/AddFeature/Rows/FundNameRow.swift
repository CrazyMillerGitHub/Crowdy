//
//  FundNameRow.swift
//  
//
//  Created by Mikhail Borisov on 20.03.2022.
//

import SwiftUI
import DesignSystem

struct FundNameRow: View {

    @Binding var fundNameText: String

    var body: some View {
        VStack {
            InputField(placeholder: "Название сбора", binding: $fundNameText) {
                TextField("", text:  $fundNameText)
            }
        }
        .padding([.leading, .trailing, .top])
    }
}
