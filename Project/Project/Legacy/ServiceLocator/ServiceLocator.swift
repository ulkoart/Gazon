//
//  ServiceLocator.swift
//  Project
//
//  Created by Улько Артем Викторович on 30.08.2022.
//

import Foundation

@available(*, deprecated, message: "Нужно использовать DIContainer")
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

	func register<T>(factory: @escaping (ServiceLocating) -> T) {
		let key = typeName(T.self)
		services[key] = factory(self)
	}

	func resolve<T>() -> T? {
		let key = typeName(T.self)
		return services[key] as? T
	}
}

/// Пример регистрации обьекта

/*

class TestServiceLocatorClass {
	 var testBool: Bool = false
}

ServiceLocator.shared.register(factory: { _ in
	let testServiceLocatorClass = TestServiceLocatorClass()
	testServiceLocatorClass.test = true
	return testServiceLocatorClass
} as (ServiceLocator) -> TestServiceLocatorClass)

if let item: TestServiceLocatorClass = ServiceLocator.shared.resolve() {
	print(item.test)
}

*/
