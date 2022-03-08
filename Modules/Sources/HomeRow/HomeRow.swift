//
//  HomeRow.swift
//  
//
//  Created by Mikhail Borisov on 06.01.2022.
//

import SwiftUI
import Core
import Combine
import DesignSystem
import ComposableArchitecture

public struct HomeRow: View {

	private let store: Store<HomeRowState, HomeRowAction>

	private struct Constants {
		static let previewHeight: CGFloat = 185
		static let padding: CGFloat = 15
		static let disabledOpacity: CGFloat = 0.5
	}

	public init(store: Store<HomeRowState, HomeRowAction>) {
		self.store = store
	}

	private struct DetailsView: View {

		private let viewStore: ViewStore<HomeRowState, HomeRowAction>

		@State private var infos: (ViewStore<HomeRowState, HomeRowAction>) -> [String] = { store in
			return [
				String(
					format: "%@ %.0f%%",
					StringFactory.HomeRow.progress.localizableString,
					store.state.crowdfunding.amountPrecentage * 100
				),
				"\(StringFactory.HomeRow.participants.localizableString) \(store.state.crowdfunding.participantsCount)",
				"\(StringFactory.HomeRow.expireOn.localizableString) 10.11.22"
			]
		}

		init(viewStore: ViewStore<HomeRowState, HomeRowAction>) {
			self.viewStore = viewStore
		}

		var body: some View {
			HStack {
				ForEach(0..<3) { idx in
					Text(infos(viewStore)[idx])
						.font(.footnote)
						.minimumScaleFactor(0.01)
						.lineLimit(1)
						.redacted(reason: viewStore.state.isLoaded ? [] : .placeholder )
						.shimmering(active: !viewStore.state.isLoaded)
				}
			}
		}
	}

	public var body: some View {
		return WithViewStore(store) { viewStore in
			VStack(alignment: .center) {
				ZStack(alignment: .bottomLeading) {
					Image(uiImage: viewStore.state.contentImage)
						.resizable()
						.background(Color.darkSpace.color)
					Image(systemName: "heart.fill")
						.foregroundColor(
							viewStore.state.crowdfunding.favourite
							? Color.white
							: Color.white.opacity(Constants.disabledOpacity)
						)
						.modifier(TopTrailingViewModifier())
						.padding(Constants.padding)
						.onTapGesture {
							viewStore.send(.favouriteButtonTapped)
						}
					Text(viewStore.state.crowdfunding.title)
						.font(.headline)
						.foregroundColor(SwiftUI.Color.white)
						.padding(Constants.padding)
				}
				.frame(height: Constants.previewHeight)
				ProgressView(value: viewStore.state.crowdfunding.amountPrecentage)
					.padding(Constants.padding / 2)
				DetailsView(viewStore: viewStore)
					.padding([.leading,  .bottom, .trailing], Constants.padding)
			}
			.background(Color.white.color)
			.modifier(RowModifier())
			.onAppear {
				viewStore.send(.onAppear)
			}
		}
	}
}

struct HomeRow_Preview: PreviewProvider {

	static var previews: some View {
		List {
			HomeRow(
				store: .init(
					initialState: HomeRowState(),
					reducer: homeRowReducer,
					environment: .dev(
						environment: HomeRowEnvironment(
							crowdfundingId: { 4 },
							crowdfundingRequest: dummyCrowdfundingEffect,
							mediaContentRequest: dummyMediaContentEffect,
							updateFavouriteRequest: dummyUpdateFavouriteEffect
						)
					)
				)
			)
		}
	}
}
