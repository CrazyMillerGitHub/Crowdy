//
//  DetailView.swift
//  
//
//  Created by Mikhail Borisov on 10.03.2022.
//

import SwiftUI
import Core
import ComposableArchitecture
import DesignSystem

public struct DetailView: View {

    private let store: Store<DetailState, DetailAction>

    public init(store: Store<DetailState, DetailAction>) {
        self.store = store
    }

    public var body: some View {
        WithViewStore(store) { viewStore in
            List {
                HeaderSection(store: store)
                ContentSection()
                Section(header: Text(StringFactory.Details.stage.localizableString)) {
                    InfoSection()
                }
                Section(header: Text(StringFactory.Details.previewImages.localizableString)) {
                    PreviewSection(viewStore: viewStore)
                }
                ActionSection(isIncoming: viewStore.state.detailModel.isIncoming)
            }
            .listStyle(.plain)
            .overlay(content: {
                VStack {
                    HStack {
                        Spacer()
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(Color.white.opacity(0.8))
                            .font(.system(.title))
                            .onTapGesture {
                                viewStore.send(.closeButtonTapped)
                            }
                            .padding(.trailing)
                    }
                    Spacer()
                }.padding(.top, 50)
            })
            .coordinateSpace(name: "SCROLL")
            .ignoresSafeArea(.container, edges: .top)
            .navigationBarHidden(true)
            .onAppear {
                viewStore.send(.onAppear)
            }
        }
    }
}

#if DEBUG
struct DetailView_Preview: PreviewProvider {

    static var previews: some View {
        return DetailView(
            store: .init(
                initialState: .init(identifier: .init()),
                reducer: detailReducer,
                environment: .dev(
                    environment: .init(loadDetailsRequest: dummyLoadDetailsRequest)
                )
            )
        )
    }
}
#endif
