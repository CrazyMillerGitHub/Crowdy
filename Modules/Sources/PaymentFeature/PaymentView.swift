//
//  PaymentView.swift
//  
//
//  Created by Mikhail Borisov on 08.03.2022.
//

#if !APPCLIP

import SwiftUI
import Stripe
import Core
import Kingfisher
import ComposableArchitecture
import DesignSystem

struct PaymentTypeView: View {
    
    var body: some View {
        TokenName.background1.color
            .cornerRadius(10)
            .frame(height: 54)
            .overlay {
                ZStack {
                    HStack {
                        Image("applePay", bundle: .main)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 40, alignment: .center)
                        Text("Apple Pay")
                            .foregroundColor(TokenName.systemInverse.color)
                            .font(.body)
                        Spacer()
                    }
                }
                .padding()
            }
    }
}

public struct PaymentView: View {

    let store: Store<PaymentState, PaymentAction>

    private let currencyFormatter: NumberFormatter = {
        let formmatter = NumberFormatter()
        formmatter.numberStyle = .currency
        formmatter.locale = .current
        formmatter.currencyCode = "RUB"
        formmatter.maximumFractionDigits = 2
        return formmatter
    }()

    public init(store: Store<PaymentState, PaymentAction>) {
        self.store = store
    }

    public var body: some View {
        WithViewStore(store) { viewStore in
            NavigationView {
                VStack(spacing: 30) {
                    InputField(placeholder: "Введите сумму", binding: viewStore.binding(\.$amount)) {
                        CurrencyTextField(
                            numberFormatter: currencyFormatter,
                            value: viewStore.binding(\.$amount)
                        )
                    }
                    PaymentTypeView()
                    Spacer()
                    PaymentButton() {
                        viewStore.send(.startPayment)
                    }
                    .cornerRadius(10)
                }
                .navigationTitle("Оформление")
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button("Закрыть") {
                            viewStore.send(.cancelTapped)
                        }.foregroundColor(TokenName.brand.color)
                    }
                }
                .padding()
                .onAppear {
                    viewStore.send(.onAppear)
                }
            }
        }
    }
}

#endif
