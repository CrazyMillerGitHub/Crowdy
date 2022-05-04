//
//  Slider.swift
//  
//
//  Created by Mikhail Borisov on 07.05.2022.
//

import SwiftUI

public struct Slider: View {

    public init() {}

    public var body: some View {
        HStack() {
            Spacer()
            RoundedRectangle(cornerRadius: 2)
                .fill(.gray.opacity(0.7))
                .frame(width: 35, height: 4)
            Spacer()
        }
    }
}
