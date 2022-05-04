//
//  FeatureAvailability.swift
//  
//
//  Created by Mikhail Borisov on 08.03.2022.
//

/// Протокол, описывающий доступность функциональности
public protocol FeatureAvailabilityProtocol {

    /// Доступность добавления карт
    var isCardAvailable: Bool { get }

    /// Доступность списка операций
    var isOperationsAvailble: Bool { get }

    /// Доступность "забыл пароль"
    var isForgetPasswordAvailable: Bool { get }

    /// Доступность регистрации пользователей
    var isRegistrationAvailable: Bool { get }

    /// Доступность превью
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
        return false
    }

    public var isPreviewAvailable: Bool {
        return true
    }

    private init() {
        debugPrint("Initialized")
    }
}
