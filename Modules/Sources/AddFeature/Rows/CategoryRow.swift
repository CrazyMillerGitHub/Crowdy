//
//  CategoryRow.swift
//  
//
//  Created by Mikhail Borisov on 20.03.2022.
//

import SwiftUI
import DesignSystem
import Core
import ComposableArchitecture

struct CategoryRow: View {

    @Binding var categoryValue: String

    var body: some View {
        VStack {
            InputField(placeholder: StringFactory.Add.category.localizableString, binding: $categoryValue) {
                TextField("", text:  $categoryValue)
            }
        }
        .padding([.leading, .trailing, .top])
    }
}
