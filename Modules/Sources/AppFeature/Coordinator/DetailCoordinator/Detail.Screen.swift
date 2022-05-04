//
//  Detail.Screen.swift
//  
//
//  Created by Mikhail Borisov on 09.05.2022.
//

import TCACoordinators
import ComposableArchitecture
import PreviewFeature
import DetailFeature
import AddFeature
import ShareQrFeature
import PaymentFeature

extension DetailCoordinator {

    public struct Environment {}

    public enum ScreenState: Equatable {
        case detail(DetailState)
        case cancel(CancelFundState)
        case preview(PreviewState)
        case share(ShareFundState)
        case payment(PaymentState)
    }

    public enum ScreenAction {
        case preview(PreviewAction)
        case detail(DetailAction)
        case share(ShareFundAction)
        case cancel(CancelFundAction)
        case payment(PaymentAction)
    }

    typealias ScreenReducer = Reducer<
        ScreenState,
        ScreenAction,
        Environment
    >

    static let screenReducer: ScreenReducer = .combine(
        detailReducer.pullback(
            state: /ScreenState.detail,
            action: /ScreenAction.detail,
            environment: { _ in
                return .dev(
                    environment: DetailEnvironment(loadDetailRequest: dummyLoadDetailRequest)
                )
            }
        ),
        cancelFundReducer.pullback(
            state: /ScreenState.cancel,
            action: /ScreenAction.cancel,
            environment: { _ in
                return .dev(
                    environment: CancelFundEnvironment()
                )
            }
        ),
        previewReducer.pullback(
            state: /ScreenState.preview,
            action: /ScreenAction.preview,
            environment: { _ in
                return .dev(
                    environment: PreviewEnvironment()
                )
            }
        ),
        paymentReducer.pullback(
            state: /ScreenState.payment,
            action: /ScreenAction.payment,
            environment: { _ in
                return .dev(
                    environment: PaymentEnvironment(
                        createPaymentRequest: dummyCreatePaymentRequest
                    )
                )
            }
        ),
        shareFundReducer.pullback(
            state: /ScreenState.share,
            action: /ScreenAction.share,
            environment: { _ in
                return .dev(
                    environment: ShareFundEnvironment(getFundURLRequest: dummyGetFundURLRequest)
                )
            }
        )
    )
}
