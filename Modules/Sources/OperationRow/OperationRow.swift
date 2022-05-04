//
//  OperationRow.swift
//  
//
//  Created by Mikhail Borisov on 09.03.2022.
//

#if !APPCLIP

import SwiftUI
import Kingfisher
import DesignSystem

public struct OperationRow: View {

    let model: OperationModel

    public init(model: OperationModel) {
        self.model = model
    }

    public var body: some View {
        HStack(alignment: .center) {
            KFImage(model.image)
                .frame(width: 38, height: 38)
                .cornerRadius(10)
                .padding(.trailing)
            VStack(alignment: .leading, spacing: 4) {
                Text(model.title)
                    .font(.body)
                Text(model.category.localizableString)
                    .font(.footnote)
                    .opacity(0.55)
            }
            Spacer()
            Text(model.price.value)
                .bold()
                .foregroundColor(TokenName.accept.color)
        }
        .padding([.top, .bottom])
    }
}

#endif

#if DEBUG
struct OperationRow_Preview: PreviewProvider {

    static var previews: some View {
        let model = OperationModel(
            title: "Best pen in the world",
            category: .electronic,
            price: .init(amount: 12, currency: "ru_RU"),
            image: .init(string: "apple.com")!
        )
        return OperationRow(model: model)
            .border(.blue, width: 1)
    }
}
#endif
