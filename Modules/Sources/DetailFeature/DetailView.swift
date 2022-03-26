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
                    InfoSection(detail: viewStore.binding(\.$detail))
                }
                Section(header: Text(StringFactory.Details.previewImages.localizableString)) {
                    PreviewSection(store: store)
                }
                ActionSection(store: store)
            }
            .listStyle(.plain)
            .overlay(content: {
                VStack {
                    HStack {
                        Spacer()
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(Color.white.opacity(0.8))
                            .font(.system(.title))
                            .unredacted()
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
            .transition(.opacity.animation(.default))
            .redacted(reason: viewStore.isLoading ? .placeholder : [])
            .shimmering(active: viewStore.isLoading)
        }
    }
}

#if DEBUG
struct DetailView_Preview: PreviewProvider {

    static var previews: some View {
        return DetailView(
            store: .init(
                initialState: .init(uuid: .init()),
                reducer: detailReducer,
                environment: .dev(
                    environment: .init(loadDetailRequest: dummyLoadDetailRequest)
                )
            )
        )
    }
}
#endif
