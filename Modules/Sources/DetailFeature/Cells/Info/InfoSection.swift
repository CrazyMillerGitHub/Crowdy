//
//  InfoSection.swift
//  
//
//  Created by Mikhail Borisov on 13.03.2022.
//

import DesignSystem
import SwiftUI

struct InfoSection: View {
    var body: some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 10)
                .frame(height: 30)
                .foregroundColor(Color.magnetta.color)
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(Color.brand.color)
                .frame(width: 100, height: 30)
            HStack(alignment: .center) {
                Spacer()
                Text("120/140")
                    .font(.caption2)
                    .foregroundColor(.white)
                Spacer()
            }
        }
        .listRowSeparator(.hidden)
    }
}
