//
//  AddView.swift
//  
//
//  Created by Mikhail Borisov on 20.03.2022.
//

import SwiftUI
import DesignSystem
import ComposableArchitecture
import Core

public struct AddView: View {

    private let store: Store<AddState, AddAction>

    public init(store: Store<AddState, AddAction>) {
        self.store = store
    }

    public var body: some View {
        WithViewStore(store) { viewStore in
            NavigationView {
                ScrollView(.vertical, showsIndicators: false) {
                    LazyVStack {
                        FundBackgroundRow()
                        FundNameRow(fundNameText: viewStore.binding(\.$titleValue))
                        ExpirationRow(expirationDateValue: viewStore.binding(\.$expirationDateValue))
                        CategoryRow(categoryValue: viewStore.binding(\.$catogoryValue))
                        Button(StringFactory.Add.publish.localizableString) {
                            viewStore.send(.publishTapped)
                        }
                        .padding([.leading, .trailing, .top])
                        .buttonStyle(BrandButtonStyle())
                    }
                    .toolbar {
                        ToolbarItem(placement: .navigationBarLeading) {
                            Button(StringFactory.Add.cancel.localizableString) {
                                viewStore.send(.cancelTapped)
                            }.foregroundColor(Color.brand.color)
                        }
                    }
                }
                .navigationTitle(StringFactory.Add.createFund.localizableString)
                .navigationBarTitleDisplayMode(.inline)
            }
        }
    }
}
