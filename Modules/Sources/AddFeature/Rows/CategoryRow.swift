//
//  CategoryRow.swift
//  
//
//  Created by Mikhail Borisov on 20.03.2022.
//

import SwiftUI
import DesignSystem
import Core

struct CategoryRow: View {

    @Binding var categoryValue: String

    var body: some View {
        VStack {
            InputField(StringFactory.Add.category.localizableString, text: $categoryValue)
        }
        .padding([.leading, .trailing, .top])
    }
}
