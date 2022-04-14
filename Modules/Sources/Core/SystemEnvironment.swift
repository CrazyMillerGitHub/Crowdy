//
//  SystemEnvironment.swift
//  Crowdy
//
//  Created by Mikhail Borisov on 05.01.2022.
//

import ComposableArchitecture

@dynamicMemberLookup
public struct SystemEnvironment<Environment> {

	public var environment: Environment
	public var mainQueue: () -> AnySchedulerOf<DispatchQueue>
	public var decoder: () -> JSONDecoder
    public var encoder: () -> JSONEncoder
    public var currentUser: () -> User
	public var storage: () -> PersistenceController
    public var paymentService: () -> PaymentServiceProtocol
    public var remoteConfig: () -> RemoteConfigProtocol
    public var featureAvailability: () -> FeatureAvailabilityProtocol

	public init(
		environment: Environment,
		mainQueue: @autoclosure @escaping () -> AnySchedulerOf<DispatchQueue>,
		decoder: @escaping () -> JSONDecoder,
        encoder: @escaping () -> JSONEncoder,
        currentUser: @escaping () -> User,
		storage: @escaping () -> PersistenceController,
        paymentService: @escaping () -> PaymentServiceProtocol,
        remoteConfig: @escaping () -> RemoteConfigProtocol,
        featureAvailability: @escaping () -> FeatureAvailabilityProtocol
	) {
		self.environment = environment
		self.mainQueue = mainQueue
		self.decoder = decoder
        self.encoder = encoder
        self.currentUser = currentUser
		self.storage = storage
        self.paymentService = paymentService
        self.remoteConfig = remoteConfig
        self.featureAvailability = featureAvailability
	}

	public subscript<Dependency>(
		dynamicMember keyPath: WritableKeyPath<Environment, Dependency>
	) -> Dependency {
		get { self.environment[keyPath: keyPath] }
		set { self.environment[keyPath: keyPath] = newValue }
	}

	private static func decoder() -> JSONDecoder {
		let decoder = JSONDecoder()
		decoder.keyDecodingStrategy = .convertFromSnakeCase
		return decoder
	}

    private static func encoder() -> JSONEncoder {
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        return encoder
    }

    private static func featureAvailability() -> FeatureAvailabilityProtocol {
        return FeatureAvailability()
    }

    private static func remoteConfig() -> RemoteConfigProtocol {
        return RemoteConfig(storage: Storage())
    }

    private static func currentUser() -> User {
        // TODO: Добавить загрузку откуда-то значения
        return User(uuid: 1)
    }

    private static func paymentService() -> PaymentServiceProtocol {
        return PaymentService()
    }

	private static func storage() -> PersistenceController {
        return PersistenceController.shared
	}

	public static func live(environment: Environment) -> Self {
		Self(
            environment: environment,
            mainQueue: .main,
            decoder: decoder,
            encoder: encoder,
            currentUser: currentUser,
            storage: storage,
            paymentService: paymentService,
            remoteConfig: remoteConfig,
            featureAvailability: featureAvailability
        )
	}

	public static func dev(environment: Environment) -> Self {
        Self(
            environment: environment,
            mainQueue: .main,
            decoder: decoder,
            encoder: encoder,
            currentUser: currentUser,
            storage: storage,
            paymentService: paymentService,
            remoteConfig: remoteConfig,
            featureAvailability: featureAvailability
        )
	}
}
