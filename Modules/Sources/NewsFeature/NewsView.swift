//
//  NewsEnvironment.swift
//  Crowdy
//
//  Created by Mikhail Borisov on 05.01.2022.
//

#if !APPCLIP

import SwiftUI
import Core
import DesignSystem
import ComposableArchitecture

/// Экран "Что нового"
public struct NewsView: View {

	private let store: Store<NewsState, NewsAction>

	public init(store: Store<NewsState, NewsAction>) {
		self.store = store
	}

	private struct NewsRow: View {

		let news: NewsModel

		private struct Constants {
			static let padding: CGFloat = 20
			static let imageHeight: CGFloat = 46
			static let verticalSpacing: CGFloat = 5
		}

		var body: some View {
			HStack {
				Image(systemName: "heart.fill")
					.resizable()
					.scaledToFit()
					.frame(width: Constants.imageHeight, height: Constants.imageHeight)
				VStack(alignment: .leading, spacing: Constants.verticalSpacing) {
					Text(news.title)
						.bold()
					Text(news.subtitle)
				}
				.padding(Constants.padding)
				Spacer()
			}.padding(.leading)
		}
	}

	public var body: some View {
		WithViewStore(store) { viewStore in
			VStack {
				Text(StringFactory.News.whatsNew.localizableString)
					.font(SwiftUI.Font.headline)
				ScrollView {
					VStack {
						ForEach(viewStore.state.news) { news in
							NewsRow(news: news)
						}
					}
				}
				.onAppear { viewStore.send(.onAppear) }
				Button(StringFactory.News.continue.localizableString) {
					viewStore.send(.continueButtonTapped)
				}
				.buttonStyle(BrandButtonStyle())
			}
            .padding()
		}
	}
}

#endif

#if DEBUG
struct NewsView_Preview: PreviewProvider {
	static var previews: some View {
		NewsView(
			store: Store(
				initialState: NewsState(),
				reducer: newsReducer,
				environment: .dev(environment: NewsEnvironment(newsRequest: dummyNewsEffect))
			)
		)
	}
}
#endif
