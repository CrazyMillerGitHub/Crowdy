//
//  PaymentEffect.swift
//  
//
//  Created by Mikhail Borisov on 26.03.2022.
//

import Foundation
import ComposableArchitecture
import Core

public struct PaymentCreationResponse {
    
}

public func dummyCreatePaymentRequest(paymentService: PaymentServiceProtocol, order: OrderDTO) -> Effect<PaymentCreationResponse, APIError> {
    paymentService.createPayment(with: order)
    return Effect(value: .init())
}
