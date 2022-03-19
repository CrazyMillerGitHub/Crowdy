//
//  HeaderSection.swift
//  
//
//  Created by Mikhail Borisov on 13.03.2022.
//

import SwiftUI

struct HeaderSection: View {
    
    var body: some View {
        GeometryReader { proxy in
            let minY = proxy.frame(in: .named("SCROLL")).minY
            let size = proxy.size
            let height = max(size.height + minY, .zero)
            Image("placeholder", bundle: .main)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: size.width, height: height, alignment: .top)
                .overlay(content: {
                    ZStack(alignment: .bottom) {
                            HStack {
                                VStack {
                                Spacer()
                                Text("Author: Mikhail Borisov")
                                    .font(.headline)
                                    .foregroundColor(Color.white.opacity(0.7))
                                Text("Modern Plane")
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
        .frame(height: 360)
        .listRowInsets(.init())
        .listRowSeparator(.hidden)
    }
}
