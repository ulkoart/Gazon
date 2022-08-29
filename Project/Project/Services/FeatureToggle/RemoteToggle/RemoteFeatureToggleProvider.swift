//
//  RemoteFeatureToggleProvider.swift
//  Project
//
//  Created by Улько Артем Викторович on 29.08.2022.
//

import Foundation

struct RemoteFeatureToggleProvider: FeatureToggleProvider {
	func fetchFeatureToggles(_ completion: @escaping ([FeatureToggle]) -> Void) {
		let service = ApiServiceProvider<RemoteFeatureToggleService>()
		service.load(service: .toggles, decodeType: [FeatureToggle].self) { result in
			switch result {
			case let .success(toggles):
				completion(toggles)
			case .failure(_):
				completion([])
			}
		}
	}
}
