//
//  LocalFeatureToggle.swift
//  Project
//
//  Created by Улько Артем Викторович on 19.09.2022.
//

import Foundation

class LocalFeatureToggle {
	private var featureToggles: [FeatureToggle] = []

	init(provider: FeatureToggleProvider) {
		provider.fetchFeatureToggles { [weak self] featureToggles in
			guard let self = self else { return }
			self.featureToggles = featureToggles
			Logger.shared.log("✅ - \(Self.self)")
		}
	}
}

extension LocalFeatureToggle: FeatureToggleProtocol {
	func isEnabled(_ feature: Feature) -> Bool {
		let feature = featureToggles.first(where: { $0.feature == feature })
		return feature?.enabled ?? false
	}
}
