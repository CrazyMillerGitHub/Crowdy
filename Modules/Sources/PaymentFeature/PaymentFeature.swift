//
//  PaymentFeature.swift
//  
//
//  Created by Mikhail Borisov on 26.03.2022.
//

#if !APPCLIP

import ComposableArchitecture
import Core

public struct PaymentState: Equatable {

    let uuid: UUID
    let title: String
    let author: String
    let image: URL
    @BindableState var amount: String = ""

    public init(
        uuid: UUID,
        title: String,
        author: String,
        image: URL
    ) {
        self.uuid = uuid
        self.title = title
        self.author = author
        self.image = image
    }
}

public enum PaymentAction: BindableAction {
    case onAppear
    case startPayment
    case cancelTapped
    case didCreatePayment(Result<PaymentCreationResponse, APIError>)
    case binding(BindingAction<PaymentState>)
}

public struct PaymentEnvironment {

    var createPaymentRequest: (PaymentServiceProtocol, OrderDTO) -> Effect<PaymentCreationResponse, APIError>

    public init(createPaymentRequest: @escaping (PaymentServiceProtocol, OrderDTO) -> Effect<PaymentCreationResponse, APIError>) {
        self.createPaymentRequest = createPaymentRequest
    }
}

public typealias PaymentReducer = Reducer<PaymentState, PaymentAction, SystemEnvironment<PaymentEnvironment>>

public var paymentReducer = PaymentReducer { state, action, environment in
    switch action {
    case.startPayment:
        return environment.createPaymentRequest(
            environment.paymentService(),
            OrderDTO(
                title: state.title,
                amount: .init(string: state.amount)
            )
        )
        .receive(on: environment.mainQueue())
        .catchToEffect()
        .map(PaymentAction.didCreatePayment)
    case _:
        return .none
    }
}.binding()

#endif
