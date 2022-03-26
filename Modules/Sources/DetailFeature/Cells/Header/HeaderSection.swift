//
//  HeaderSection.swift
//  
//
//  Created by Mikhail Borisov on 13.03.2022.
//

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
                                        Text(viewStore.detail.title)
                                            .foregroundColor(Color.white)
                                            .font(.title)
                                            .bold()
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
