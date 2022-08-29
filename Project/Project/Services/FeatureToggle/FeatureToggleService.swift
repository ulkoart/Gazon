//
//  FeatureToggleService.swift
//  Project
//
//  Created by Улько Артем Викторович on 29.08.2022.
//

import Foundation

final class FeatureToggleService {
	static let shared = FeatureToggleService()
	private var featureToggles: [FeatureToggle] = []
	
	private init() { }
	
	func isEnabled(_ feature: Feature) -> Bool {
		let feature = featureToggles.first(where: { $0.feature == feature })
		return feature?.enabled ?? false
	}
	
	func fetchFeatureToggles(provider: FeatureToggleProvider, complition: @escaping () -> Void) {
		provider.fetchFeatureToggles { featureToggles in
			self.featureToggles = featureToggles
			complition()
		}
	}
}
