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

    public init(fundNameText: Binding<String>) {
        _fundNameText = fundNameText
    }

    var body: some View {
        VStack {
            InputField("Название сбора", text: $fundNameText)
        }
        .padding([.leading, .trailing, .top])
    }
}
