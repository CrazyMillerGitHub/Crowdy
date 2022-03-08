//
//  SystemEnvironment.swift
//  Crowdy
//
//  Created by Mikhail Borisov on 05.01.2022.
//

import ComposableArchitecture

public protocol StorageProtocol {
	
}

struct Storage: StorageProtocol {}

@dynamicMemberLookup
public struct SystemEnvironment<Environment> {

	public var environment: Environment
	public var mainQueue: () -> AnySchedulerOf<DispatchQueue>
	public var decoder: () -> JSONDecoder
	public var storage: () -> StorageProtocol

	public init(
		environment: Environment,
		mainQueue: @escaping () -> AnySchedulerOf<DispatchQueue>,
		decoder: @escaping () -> JSONDecoder,
		storage: @escaping () -> StorageProtocol
	) {
		self.environment = environment
		self.mainQueue = mainQueue
		self.decoder = decoder
		self.storage = storage
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

	private static func storage() -> StorageProtocol {
		return Storage()
	}

	public static func live(environment: Environment) -> Self {
		Self(environment: environment, mainQueue: { .main }, decoder: decoder, storage: storage)
	}

	public static func dev(environment: Environment) -> Self {
		Self(environment: environment, mainQueue: { .main }, decoder: decoder, storage: storage)
	}
}
