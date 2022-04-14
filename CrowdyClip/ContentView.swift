//
//  ContentView.swift
//  CrowdyClip
//
//  Created by Mikhail Borisov on 22.03.2022.
//

import SwiftUI
import AppFeature

struct ContentView: View {
    var body: some View {
        RootView(
            store: .init(
                initialState: .initialState,
                reducer: mainTabCoordinatorReducer,
                environment: .init()
            )
        )
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        RootView(
            store: .init(
                initialState: .initialState,
                reducer: mainTabCoordinatorReducer,
                environment: .init()
            )
        )
    }
}
#endif
