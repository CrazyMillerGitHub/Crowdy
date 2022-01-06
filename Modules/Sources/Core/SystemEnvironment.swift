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

	public static func live(environment: Environment) -> Self {
		Self(environment: environment, mainQueue: { .main }, decoder: decoder)
	}

	public static func dev(environment: Environment) -> Self {
		Self(environment: environment, mainQueue: { .main }, decoder: decoder)
	}
}
