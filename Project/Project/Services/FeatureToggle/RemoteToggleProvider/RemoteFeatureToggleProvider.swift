//
//  RemoteFeatureToggleProvider.swift
//  Project
//
//  Created by Улько Артем Викторович on 29.08.2022.
//

import Foundation

/// Провайдер тоглов с сервера
struct RemoteFeatureToggleProvider: FeatureToggleProvider {
	func fetchFeatureToggles(_ completion: @escaping ([FeatureToggle]) -> Void) {
		guard let service: ApiServiceProvider<RemoteFeatureToggleService> = ServiceLocator.shared.resolve() else {
			completion([])
			return
		}

		service.load(service: .toggles, decodeType: [FeatureToggle].self) { result in
			switch result {
			case let .success(toggles):
				completion(toggles)
			case .failure:
				completion([])
			}
		}
	}
}
