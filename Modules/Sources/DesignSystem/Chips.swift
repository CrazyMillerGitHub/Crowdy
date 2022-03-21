//
//  Chips.swift
//  
//
//  Created by Mikhail Borisov on 20.03.2022.
//

import SwiftUI

public struct Chips: View {

    @Environment(\.colorScheme) private var colorScheme
    @Binding private var isSelected: Bool
    private let title: String

    public init(title: String, binding: Binding<Bool>) {
        self.title = title
        self._isSelected = binding
    }

    public var body: some View {
        Text(title)
            .font(.caption)
            .foregroundColor(titleColor(isSelected: isSelected))
            .padding([.leading, .trailing])
            .padding([.top, .bottom], 8)
            .background(backgrounColor(isSelected: isSelected))
            .cornerRadius(10)
            .onTapGesture {
                isSelected.toggle()
            }
            .animation(.easeOut, value: isSelected)
    }

    func backgrounColor(isSelected: Bool) -> SwiftUI.Color {
        guard colorScheme == .dark else {
            return isSelected ? Color.brand.color : .black.opacity(0.05)
        }
        return isSelected ? Color.brand.color : Color.darkContent.color
    }

    func titleColor(isSelected: Bool) -> SwiftUI.Color {
        guard colorScheme == .dark else {
            return isSelected ? Color.white.color : Color.darkSpace.color
        }
        return Color.white.color
    }
}
