//
//  FundSelectionView.swift
//  
//
//  Created by Mikhail Borisov on 02.05.2022.
//

import SwiftUI
import DesignSystem
import ComposableArchitecture
import Core

public struct FundSelectionView: View {

    public let store: Store<FundSelectionState, FundSelectionAction>

    public init(store: Store<FundSelectionState, FundSelectionAction>) {
        self.store = store
    }

    public var body: some View {
        WithViewStore(store) { viewStore in
            BottomSheet {
                VStack(alignment: .leading, spacing: 20) {
                    Slider()
                    Text(StringFactory.FundSelection.createFund.localizableString)
                        .font(.title2)
                        .bold()
                    VStack(alignment: .leading, spacing: 5) {
                        Text(StringFactory.FundSelection.externalFund.localizableString)
                            .font(.body)
                            .bold()
                        Text(StringFactory.FundSelection.externalDescription.localizableString)
                            .font(.footnote)
                            .opacity(0.7)
                    }
                    .onTapGesture {
                        viewStore.send(.externalFundTapped)
                    }
                    VStack(alignment: .leading, spacing: 5) {
                        Text(StringFactory.FundSelection.internalFund.localizableString)
                            .font(.body)
                            .bold()
                        Text(StringFactory.FundSelection.internalDescription.localizableString)
                            .font(.footnote)
                            .opacity(0.7)
                    }
                    .padding(.bottom)
                    .onTapGesture {
                        viewStore.send(.internalFundTapped)
                    }
                }
                .padding(.bottom)
            }
        }
    }
}
