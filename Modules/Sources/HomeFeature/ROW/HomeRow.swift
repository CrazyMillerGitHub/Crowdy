//
//  HomeRow.swift
//  
//
//  Created by Mikhail Borisov on 06.01.2022.
//

import SwiftUI
import Core
import Combine
import SDWebImageSwiftUI
import DesignSystem
import ComposableArchitecture

public struct HomeRow: View {

    @Environment(\.colorScheme) var colorScheme

	private struct Constants {
		static let previewHeight: CGFloat = 185
		static let padding: CGFloat = 15
		static let disabledOpacity: CGFloat = 0.5
	}
    private let viewStore: ViewStore<HomeState, HomeAction>
    private let fund: Fund

    public init(viewStore: ViewStore<HomeState, HomeAction>, fund: Fund) {
        self.viewStore = viewStore
        self.fund = fund
    }

	public var body: some View {
        return VStack(alignment: .center) {
            ZStack(alignment: .bottomLeading) {
                WebImage(url: fund.image)
                    .resizable()
                    .background(Color.white)
                    .shimmering(active: !viewStore.isLoaded)
                Image(systemName: "heart.fill")
                    .foregroundColor(
                        fund.isFavorite
                        ? Color.white
                        : Color.white.opacity(Constants.disabledOpacity)
                    )
                    .modifier(TopTrailingViewModifier())
                    .padding(Constants.padding)
                    .onTapGesture {
                        viewStore.send(.toggleFavorite(fund.id))
                    }
                Text(fund.title)
                    .font(.headline)
                    .foregroundColor(SwiftUI.Color.white)
                    .padding(Constants.padding)
                    .shimmering(active: !viewStore.isLoaded)
            }
            .frame(height: Constants.previewHeight)
            ProgressView(value: fund.amountPrecentage)
                .padding(Constants.padding / 2)
            HomeRowDetail(fund: fund)
                .padding([.leading,  .bottom, .trailing], Constants.padding)
        }
        .modifier(RowModifier())
        .background(colorScheme == .dark ? Color.darkContent.color : .white)
        .cornerRadius(10)
        .shadow(color: .black.opacity(0.10), radius: 5, x: 0, y: 0)
        .onTapGesture {
            viewStore.send(.selectFund(fund.id))
        }
	}
}
