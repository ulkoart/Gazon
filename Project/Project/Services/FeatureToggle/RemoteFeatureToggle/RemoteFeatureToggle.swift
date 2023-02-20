//
//  RemoteFeatureToggle.swift
//  Project
//
//  Created by Улько Артем Викторович on 19.09.2022.
//

import Foundation

final class RemoteFeatureToggle {
	private var featureToggles: [FeatureToggle] = []

	init(provider: FeatureToggleProvider, complition: @escaping () -> Void) {
		provider.fetchFeatureToggles { [weak self] featureToggles in
			self?.featureToggles = featureToggles
			complition()
			Logger.shared.log("✅ - \(Self.self)")
		}
	}
}

extension RemoteFeatureToggle: FeatureToggleProtocol {
	func isEnabled(_ feature: Feature) -> Bool {
		let feature = featureToggles.first(where: { $0.feature == feature })
		return feature?.enabled ?? false
	}
}
