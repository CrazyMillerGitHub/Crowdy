//
//  PreviewSection.swift
//  
//
//  Created by Mikhail Borisov on 13.03.2022.
//

import SwiftUI
import ComposableArchitecture

struct PreviewSection: View {

    private let items = 0..<10
    private let viewStore: ViewStore<DetailState, DetailAction>

    private enum Constants {
        static let height: CGFloat = 64.0
        static let cornerRadius: CGFloat = 10
    }

    public init(viewStore: ViewStore<DetailState, DetailAction>) {
        self.viewStore = viewStore
    }

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack {
                ForEach(items) { idx in
                    RoundedRectangle(cornerRadius: Constants.cornerRadius)
                        .frame(width: Constants.height, height: Constants.height)
                        .foregroundColor(Color.red)
                        .onTapGesture {
                            viewStore.send(.previewTapped(UUID()))
                        }
                }
            }
        }
        .padding(.bottom)
        .listRowSeparator(.hidden)
    }
}
