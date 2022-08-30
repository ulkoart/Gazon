//
//  ServiceLocator.swift
//  Project
//
//  Created by Улько Артем Викторович on 30.08.2022.
//

import Foundation

final class ServiceLocator {
	private lazy var services = [String: Any]()

	static let shared = ServiceLocator()

	private init() {}

	private func typeName(_ some: Any) -> String {
		return (some is Any.Type) ? "\(some)" : "\(type(of: some))"
	}

}

extension ServiceLocator: ServiceLocating {
	func register<T>(service: T) {
		let key = typeName(T.self)
		services[key] = service
	}

	func resolve<T>() -> T? {
		let key = typeName(T.self)
		return services[key] as? T
	}
}
