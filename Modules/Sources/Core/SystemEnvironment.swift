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
	public var storage: () -> StorageProtocol
    public var remoteConfig: () -> RemoteConfigProtocol
    public var featureAvailability: () -> FeatureAvailabilityProtocol

	public init(
		environment: Environment,
		mainQueue: @autoclosure @escaping () -> AnySchedulerOf<DispatchQueue>,
		decoder: @escaping () -> JSONDecoder,
		storage: @escaping () -> StorageProtocol,
        remoteConfig: @escaping () -> RemoteConfigProtocol,
        featureAvailability: @escaping () -> FeatureAvailabilityProtocol
	) {
		self.environment = environment
		self.mainQueue = mainQueue
		self.decoder = decoder
		self.storage = storage
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

    private static func featureAvailability() -> FeatureAvailabilityProtocol {
        return FeatureAvailability()
    }

    private static func remoteConfig() -> RemoteConfigProtocol {
        return RemoteConfig(storage: storage())
    }

	private static func storage() -> StorageProtocol {
		return Storage()
	}

	public static func live(environment: Environment) -> Self {
		Self(
            environment: environment,
            mainQueue: .main,
            decoder: decoder,
            storage: storage,
            remoteConfig: remoteConfig,
            featureAvailability: featureAvailability
        )
	}

	public static func dev(environment: Environment) -> Self {
        Self(
            environment: environment,
            mainQueue: .main,
            decoder: decoder,
            storage: storage,
            remoteConfig: remoteConfig,
            featureAvailability: featureAvailability
        )
	}
}
