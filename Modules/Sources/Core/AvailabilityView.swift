//
//  AvailabilityView.swift
//  
//
//  Created by Mikhail Borisov on 26.03.2022.
//

import SwiftUI

public struct AvailabilityView<Content: View>: View {

    private let content: Content
    private let isAvailable: Bool

    public init(_ isAvailable: Bool, @ViewBuilder content: () -> Content) {
        self.content = content()
        self.isAvailable = isAvailable
    }

    public var body: some View {
        if isAvailable {
            content
        } else {
            EmptyView()
        }
    }
}
