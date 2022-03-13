//
//  HeaderSection.swift
//  
//
//  Created by Mikhail Borisov on 13.03.2022.
//

import SwiftUI

struct HeaderSection: View {

    var body: some View {
        ZStack(alignment: .leading) {
            Image("placeholder", bundle: .main)
                .resizable()
                .scaledToFill()
            VStack(alignment: .leading) {
                Spacer()
                Text("Author: Mikhail Borisov")
                    .font(.headline)
                    .foregroundColor(Color.white.opacity(0.7))
                Text("Modern Plane")
                    .foregroundColor(Color.white)
                    .font(.title)
                    .bold()
            }.padding()
        }
        .frame(height: 360)
        .listRowInsets(.init())
        .listRowSeparator(.hidden)
    }
}
