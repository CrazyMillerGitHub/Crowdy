//
//  BottomSheet.swift
//  
//
//  Created by Mikhail Borisov on 19.04.2022.
//

import SwiftUI

public struct BottomSheet<Content: View>: View {

    private let content: Content

    public init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    public var body: some View {
        VStack {
            Spacer()
            content
            .padding()
            .background {
                SwiftUI.Color(UIColor.systemBackground)
                    .cornerRadius(10, corners: [.topLeft, .topRight])
            }
        }
        .ignoresSafeArea(.container)
        .background(BackgroundHelper())
    }
}

struct BackgroundHelper: UIViewRepresentable {

    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        DispatchQueue.main.async {
            // find first superview with color and make it transparent
            var parent = view.superview
            repeat {
                if parent?.backgroundColor != nil {
                    parent?.backgroundColor = UIColor.clear
                    break
                }
                parent = parent?.superview
            } while (parent != nil)
        }
        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) {}
}

public struct RoundedCorner: Shape {

    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    public init(radius: CGFloat = .infinity, corners: UIRectCorner = .allCorners) {
        self.radius = radius
        self.corners = corners
    }

    public func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

extension View {

    public func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}
