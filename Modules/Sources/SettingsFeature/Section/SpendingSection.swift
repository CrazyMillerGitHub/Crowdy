//
//  SpendingSection.swift
//  
//
//  Created by Mikhail Borisov on 26.03.2022.
//

import SwiftUI
import Core

struct SpendingSection: View {

    @Binding
    var spentAmount: Price

    init(spentAmount: Binding<Price>) {
        self._spentAmount = spentAmount
    }

    var body: some View {
        Section(header: Text(StringFactory.Settings.spent.localizableString)) {
            Text(spentAmount.value)
                .font(.system(size: 25, weight: .semibold))
                .listRowSeparator(.hidden)
        }
    }
}
