//
//  FeatureToggleService.swift
//  Project
//
//  Created by Улько Артем Викторович on 29.08.2022.
//

import Foundation

final class FeatureToggleService {
	private let provider: FeatureToggleProvider
	var featureToggles: [FeatureToggle] = []
	
	init(_ provider: FeatureToggleProvider) {
		self.provider = provider
	}
	
	func isEnabled(_ feature: Feature) -> Bool {
		let feature = featureToggles.first(where: { $0.feature == feature })
		return feature?.enabled ?? false
	}
	
	func fetchToggles(complition: @escaping () -> Void) {
		provider.fetchFeatureToggles { [weak self] featureToggles in
			self?.featureToggles = featureToggles
			complition()
		}
	}
}
