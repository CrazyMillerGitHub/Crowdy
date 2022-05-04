//
//  CardSection.swift
//  
//
//  Created by Mikhail Borisov on 26.03.2022.
//

#if !APPCLIP

import SwiftUI
import DesignSystem
import ComposableArchitecture

struct CardSection: View {

    let store: Store<SettingsState, SettingsAction>

    init(store: Store<SettingsState, SettingsAction>) {
        self.store = store
    }

    var body: some View {
        WithViewStore(store) { viewStore in
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(TokenName.brand.color)
                    .frame(height: 164)
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Image(systemName: "plus.square")
                            .font(.title)
                            .foregroundColor(Color.white)
                        Spacer()
                    }
                    Spacer()
                }
            }
            .listRowSeparator(.hidden)
        }
    }
}

#endif
