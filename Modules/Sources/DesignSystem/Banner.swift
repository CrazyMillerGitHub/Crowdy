//
//  Banner.swift
//  
//
//  Created by Mikhail Borisov on 03.05.2022.
//

import SwiftUI

public struct Banner: View {

    private let title: String
    private let subtitle: String
    private let image: String
    @State
    private var bannerColor: TokenName = .background1

    public init(
        title: String = "",
        subtitle: String = "",
        image: String = "heart.fill"
    ) {
        self.title = title
        self.subtitle = subtitle
        self.image = image
    }

    public var body: some View {
        HStack(alignment: .center, spacing: 20) {
            Image(systemName: image)
                .resizable()
                .scaledToFit()
                .frame(width: 32, height: 32)
            VStack(alignment: .leading, spacing: 12) {
                Text(title)
                    .font(.body)
                Text(subtitle)
                    .font(.footnote)
                    .opacity(0.55)
            }
            Spacer()
        }
        .padding(16.0)
        .background(bannerColor.color)
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }

    mutating func bannerColor(color: TokenName) -> some View {
        bannerColor = color
        return self
    }
}

#if DEBUG

struct Banner_Preview: PreviewProvider {

    static var previews: some View {
        VStack {
            Spacer()
            Banner(
                title: "Ваши данные защищены",
                subtitle: "При переходе по ссылке или QR ваш номер телефона будет скрыт"
            )
            .padding()
            Spacer()
        }
    }
}

#endif
