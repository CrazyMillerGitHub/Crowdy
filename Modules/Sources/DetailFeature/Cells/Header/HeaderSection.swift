//
//  HeaderSection.swift
//  
//
//  Created by Mikhail Borisov on 13.03.2022.
//

#if !APPCLIP

import SwiftUI
import Kingfisher
import ComposableArchitecture

struct HeaderSection: View {

    private let store: Store<DetailState, DetailAction>

    init(store: Store<DetailState, DetailAction>) {
        self.store = store
    }
    
    var body: some View {
        WithViewStore(store) { viewStore in
            GeometryReader { proxy in
                let minY = proxy.frame(in: .named("SCROLL")).minY
                let size = proxy.size
                let height = max(size.height + minY, .zero)
                KFImage(viewStore.detail.fund.image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: size.width, height: height, alignment: .top)
                    .overlay(content: {
                        ZStack(alignment: .bottom) {
                                HStack {
                                    VStack(alignment: .leading) {
                                        Spacer()
                                        Text(viewStore.detail.author)
                                            .font(.headline)
                                            .foregroundColor(Color.white.opacity(0.7))
                                        HStack {
                                            Text(viewStore.detail.title)
                                                .foregroundColor(Color.white)
                                                .font(.title)
                                                .bold()
                                            Spacer()
                                            Image(systemName: "heart.fill")
                                                .foregroundColor(.white)
                                            Image(systemName: "square.and.arrow.up")
                                                .foregroundColor(.white)
                                                .onTapGesture {
                                                    viewStore.send(.shareTapped(URL(string: "apple.com")!))
                                                }
                                        }
                                    }
                                    Spacer()
                                }
                        }
                        .padding()
                    })
                    .cornerRadius(0)
                    .offset(y: -minY)
            }
        }
        .frame(height: 360)
        .listRowInsets(.init())
        .listRowSeparator(.hidden)
    }
}

#endif
