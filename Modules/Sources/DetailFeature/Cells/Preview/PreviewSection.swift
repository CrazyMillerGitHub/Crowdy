//
//  PreviewSection.swift
//  
//
//  Created by Mikhail Borisov on 13.03.2022.
//

import SwiftUI

struct PreviewSection: View {

    private let items = 0..<10

    private enum Constants {
        static let height: CGFloat = 64.0
        static let cornerRadius: CGFloat = 10
    }

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack {
                ForEach(items) { idx in
                    RoundedRectangle(cornerRadius: Constants.cornerRadius)
                        .frame(width: Constants.height, height: Constants.height)
                        .foregroundColor(Color.red)
                        .onTapGesture {
                            print(idx)
                        }
                }
            }
        }
        .padding(.bottom)
        .listRowSeparator(.hidden)
    }
}
