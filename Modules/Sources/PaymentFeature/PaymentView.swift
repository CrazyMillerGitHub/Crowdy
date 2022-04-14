//
//  PaymentView.swift
//  
//
//  Created by Mikhail Borisov on 08.03.2022.
//

import SwiftUI
import Stripe
import Core
import Kingfisher
import ComposableArchitecture
import DesignSystem

public struct PaymentView: View {
    
    let store: Store<PaymentState, PaymentAction>
    
    public init(store: Store<PaymentState, PaymentAction>) {
        self.store = store
    }
    
    public var body: some View {
        WithViewStore(store) { viewStore in
            NavigationView {
                VStack(spacing: 20) {
                        HStack {
                            KFImage(viewStore.image)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 90, height: 90)
                                .cornerRadius(10)
                            VStack(alignment: .leading, spacing: 10) {
                                Text(viewStore.title)
                                    .bold()
                                Text("Создатель: " + viewStore.author)
                                    .foregroundColor(Color.black.opacity(0.7))
                            }
                            
                            Spacer()
                        }
                    InputField(placeholder: "Введите сумму", binding: viewStore.binding(\.$amount)) {
                        TextField("", text: viewStore.binding(\.$amount))
                            .keyboardType(.decimalPad)
                    }
                    Spacer()
                    PaymentButton() {
                        viewStore.send(.startPayment)
                    }
                }
            .navigationTitle("Оформление")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Закрыть") {
                        viewStore.send(.cancelTapped)
                    }.foregroundColor(Color.brand.color)
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
