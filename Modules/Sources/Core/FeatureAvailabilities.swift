//
//  FeatureAvailability.swift
//  
//
//  Created by Mikhail Borisov on 08.03.2022.
//

public protocol FeatureAvailabilityProtocol {

    var isCardAvailable: Bool { get }
    var isOperationsAvailble: Bool { get }
}

/// Конфиг с доступностью фичей из лаунчера
final public class FeatureAvailability: FeatureAvailabilityProtocol {

    public init() {
        debugPrint("FeatureAvailability Initialized")
    }

    public var isCardAvailable: Bool {
        return false
    }

    public var isOperationsAvailble: Bool {
        return true
    }
}
