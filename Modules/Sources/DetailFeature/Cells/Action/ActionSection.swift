//
//  SentSection.swift
//  
//
//  Created by Mikhail Borisov on 13.03.2022.
//

#if !APPCLIP

import SwiftUI
import Core
import ComposableArchitecture
import DesignSystem

struct ActionSection: View {

    private let store: Store<DetailState, DetailAction>

    init(store: Store<DetailState, DetailAction>) {
        self.store = store
    }

    var body: some View {
        WithViewStore(store) { viewStore in
            VStack(alignment: .center, spacing: 10.0) {
                Button(
                    viewStore.detail.isIncoming
                    ? StringFactory.Details.donate.localizableString
                    : StringFactory.Details.cancel.localizableString
                ) {
                    viewStore.detail.isIncoming
                    ? viewStore.send(.startTransactionOrder(viewStore.uuid, viewStore.detail.title, viewStore.detail.author, viewStore.detail.fund.image))
                    : viewStore.send(.startCancellingOrder)
                }
                .buttonStyle(BrandButtonStyle(color: viewStore.detail.isIncoming ? .brand : .critical))
                HStack(alignment: .center) {
                    Text("Совершая перевод, вы соглашаетесь \nс [пользовательским соглашением](https://mirror-atlasaurus-8f4.notion.site/Crowdy-3247efb360424569b26877decab13f90)")
                        .font(.footnote)
                        .multilineTextAlignment(.center)
                }
            }
            .padding(.bottom)
            .listRowSeparator(.hidden)
        }
    }
}

#endif
