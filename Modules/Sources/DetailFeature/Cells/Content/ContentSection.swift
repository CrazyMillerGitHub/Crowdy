//
//  ContentSection.swift
//  
//
//  Created by Mikhail Borisov on 13.03.2022.
//

import SwiftUI
import ComposableArchitecture

struct ContentSection: View {

    let store: Store<DetailState, DetailAction>

    init(store: Store<DetailState, DetailAction>) {
        self.store = store
    }

    var body: some View {
        WithViewStore(store) { viewStore in
            Text(.init(viewStore.detail.info))
                .padding(.top)
                .listRowSeparator(.hidden)
            
        }
    }
}
