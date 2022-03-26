//
//  HomeRow.swift
//  
//
//  Created by Mikhail Borisov on 06.01.2022.
//

import SwiftUI
import Core
import Combine
import Kingfisher
import DesignSystem
import ComposableArchitecture

public struct HomeRow: View {

    @Environment(\.colorScheme) var colorScheme

	private struct Constants {
		static let previewHeight: CGFloat = 185
		static let padding: CGFloat = 15
		static let disabledOpacity: CGFloat = 0.5
	}
    private let store: Store<HomeState, HomeAction>
    private let fund: Fund

    public init(store: Store<HomeState, HomeAction>, fund: Fund) {
        self.store = store
        self.fund = fund
    }

	public var body: some View {
        WithViewStore(store) { viewStore in
            VStack(alignment: .center) {
                ZStack(alignment: .bottomLeading) {
                    KFImage(fund.image)
                        .resizable()
                        .background(Color.white)
                        .shimmering(active: viewStore.isLoading)
                    Image(systemName: "heart.fill")
                        .foregroundColor(
                            fund.isFavorite
                            ? Color.white
                            : Color.white.opacity(Constants.disabledOpacity)
                        )
                        .modifier(TopTrailingViewModifier())
                        .padding(Constants.padding)
                        .animation(.easeOut, value: fund.isFavorite)
                        .onTapGesture {
                            viewStore.send(.toggleFavorite(fund.id))
                        }
                    Text(fund.title)
                        .font(.headline)
                        .foregroundColor(SwiftUI.Color.white)
                        .padding(Constants.padding)
                }
                .frame(height: Constants.previewHeight)
                ProgressView(value: fund.amountPrecentage)
                    .padding(Constants.padding / 2)
                HomeRowDetail(fund: fund)
                    .padding([.leading,  .bottom, .trailing], Constants.padding)
            }
            .modifier(RowModifier())
            .onTapGesture {
                viewStore.send(.selectFund(fund.id))
            }
        }
	}
}
