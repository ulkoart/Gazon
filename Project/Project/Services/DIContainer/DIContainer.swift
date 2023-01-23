//
//  DIContainer.swift
//  Project
//
//  Created by Улько Артем Викторович on 20.10.2022.
//

import Foundation

protocol DIContainerProtocol {
	func register<Service>(type: Service.Type, factoryClosure: @escaping (DIContainerProtocol) -> AnyObject)
	func registerSingleton<Service>(type: Service.Type, singletonInstance: Service)
	func resolve<Service>(type: Service.Type) -> Service?
}

class DIContainer: DIContainerProtocol {

	static let shared: DIContainerProtocol = DIContainer()

	private init() {}

	var services = [String: Any]()

	func register<Service>(type: Service.Type, factoryClosure: @escaping (DIContainerProtocol) -> AnyObject) {
		services["\(type)"] = factoryClosure
	}

	func registerSingleton<Service>(type: Service.Type, singletonInstance: Service) {
		services["\(type)"] = singletonInstance
	}

	func resolve<Service>(type: Service.Type) -> Service? {

		if let factory = services["\(type)"] as? (DIContainerProtocol) -> AnyObject {
			return factory(self) as? Service
		} else if let singletonService = services["\(type)"] as? Service {
			return singletonService
		}

		return nil
	}
}
