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
    //    func applePayContext(_ context: STPApplePayContext, didCreatePaymentMethod paymentMethod: StripeAPI.PaymentMethod, paymentInformation: PKPayment, completion: @escaping STPIntentClientSecretCompletionBlock) {
    //        // When the Apple Pay sheet is confirmed, create a PaymentIntent on your backend from the provided PKPayment information.
    //        BackendModel.shared.fetchPaymentIntent() { secret in
    //          if let clientSecret = secret {
    //            // Call the completion block with the PaymentIntent's client secret.
    //            completion(clientSecret, nil)
    //          } else {
    //            completion(nil, NSError())
    //          }
    //        }
    //    }
    //
    //    func applePayContext(_ context: STPApplePayContext, didCompleteWith status: STPApplePayContext.PaymentStatus, error: Error?) {
    //        // When the payment is complete, display the status.
    //        self.paymentStatus = status
    //        self.lastPaymentError = error
    //    }
}
