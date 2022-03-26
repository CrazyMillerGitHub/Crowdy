//
//  PreviewSection.swift
//  
//
//  Created by Mikhail Borisov on 13.03.2022.
//

import SwiftUI
import DesignSystem
import Kingfisher
import ComposableArchitecture

struct PreviewSection: View {

    private let store: Store<DetailState, DetailAction>
    @Environment(\.colorScheme) var colorScheme

    private enum Constants {
        static let height: CGFloat = 64.0
        static let cornerRadius: CGFloat = 10
    }

    public init(store: Store<DetailState, DetailAction>) {
        self.store = store
    }

    var body: some View {
        WithViewStore(store) { viewStore in
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack {
                    ForEach(viewStore.previews, id: \.self) { preview in
                        KFImage(preview)
                            .resizable()
                            .scaledToFill()
                            .frame(width: Constants.height, height: Constants.height)
                            .cornerRadius(10)
                            .foregroundColor(colorScheme == .dark ? Color.darkContent.color : Color.lightContent.color)
                            .onTapGesture {
                                viewStore.send(.previewTapped(preview))
                            }.padding(.vertical)
                    }
                }
            }
        }
        .padding(.bottom)
        .listRowSeparator(.hidden)
    }
}
