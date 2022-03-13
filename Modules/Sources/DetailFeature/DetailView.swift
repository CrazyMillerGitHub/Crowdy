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
            ZStack {
                List {
                    HeaderSection()
                    ContentSection()
                    Section(header: Text(StringFactory.Details.stage.localizableString)) {
                        InfoSection()
                    }
                    Section(header: Text(StringFactory.Details.previewImages.localizableString)) {
                        PreviewSection()
                    }
                    ActionSection(isIncoming: false)
                }
                .listStyle(.plain)
                .ignoresSafeArea(.container, edges: .top)
                VStack(alignment: .trailing) {
                    HStack {
                        Spacer()
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(Color.white.opacity(0.8))
                            .font(.system(.title))
                            .onTapGesture {
                            }
                            .padding(.trailing)
                    }
                    Spacer()
                }
            }
        }
    }
}

#if DEBUG
struct DetailView_Preview: PreviewProvider {

    static var previews: some View {
        return DetailView(store: .init(initialState: .init(),
                                       reducer: detailReducer,
                                       environment: .dev(environment: .init())
                                      ))
    }
}
#endif
