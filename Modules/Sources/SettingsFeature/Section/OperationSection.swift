//
//  OperationSection.swift
//  
//
//  Created by Mikhail Borisov on 25.03.2022.
//

import SwiftUI
import Core
import DesignSystem
import OperationRow
import ComposableArchitecture

struct OperationSection: View {

    let store: Store<SettingsState, SettingsAction>

    var body: some View {
        WithViewStore(store) { viewStore in
            Section {
                ForEach(viewStore.operations, id: \.self) { model in
                    OperationRow(model: model)
                }.listRowSeparator(.hidden)
            } header: {
                Text(StringFactory.Settings.recentCrowdfundings.localizableString)
            } footer: {}
                .redacted(reason: viewStore.isOperationsLoading ? .placeholder : [])
                .shimmering(active: viewStore.isOperationsLoading)
        }
    }
}
