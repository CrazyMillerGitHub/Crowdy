//
//  PaymentService.swift
//  
//
//  Created by Mikhail Borisov on 26.03.2022.
//

import Foundation
import Stripe
import PassKit

public protocol PaymentServiceProtocol {

    func createPayment(with order: OrderDTO)
}

final public class PaymentService : NSObject, ObservableObject, STPApplePayContextDelegate, PaymentServiceProtocol {

    @Published var paymentStatus: STPPaymentStatus?
    @Published var lastPaymentError: Error?

    public func createPayment(with order: OrderDTO) {
        let request = StripeAPI.paymentRequest(
            withMerchantIdentifier: "merchant.com.stripetest.appclipexample",
            country: "RU",
            currency: "RUB"
        )
        request.requiredShippingContactFields = []
        request.requiredBillingContactFields = []
        request.paymentSummaryItems = [
            PKPaymentSummaryItem(label: order.title, amount: order.amount)
        ]
        let applePayContext = STPApplePayContext(paymentRequest: request, delegate: self)
        applePayContext?.presentApplePay()
    }

    public func applePayContext(
        _ context: STPApplePayContext,
        didCreatePaymentMethod paymentMethod: STPPaymentMethod,
        paymentInformation: PKPayment,
        completion: @escaping STPIntentClientSecretCompletionBlock
    ) {
    }

    public func applePayContext(
        _ context: STPApplePayContext,
        didCompleteWith status: STPPaymentStatus,
        error: Error?
    ) {
        paymentStatus = status
        lastPaymentError = error
    }
}
