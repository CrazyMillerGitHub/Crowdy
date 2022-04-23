//
//  FeatureAvailability.swift
//  
//
//  Created by Mikhail Borisov on 08.03.2022.
//

public protocol FeatureAvailabilityProtocol {
    var isCardAvailable: Bool { get }
    var isOperationsAvailble: Bool { get }
    var isForgetPasswordAvailable: Bool { get }
    var isRegistrationAvailable: Bool { get }
    var isPreviewAvailable: Bool { get }
}

/// Конфиг с доступностью фичей из лаунчера
final public class FeatureAvailability: FeatureAvailabilityProtocol {

    static let shared = FeatureAvailability()

    public var isCardAvailable: Bool {
        return false
    }

    public var isOperationsAvailble: Bool {
        return true
    }

    public var isForgetPasswordAvailable: Bool {
        return true
    }

    public var isRegistrationAvailable: Bool {
        return true
    }

    public var isPreviewAvailable: Bool {
        return true
    }

    private init() {
        debugPrint("Initialized")
    }
}
