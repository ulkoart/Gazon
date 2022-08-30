//
//  FeatureToggleService.swift
//  Project
//
//  Created by Улько Артем Викторович on 29.08.2022.
//

import Foundation

protocol FeatureToggleServiceProtocol {
	func isEnabled(_ feature: Feature) -> Bool
	func fetchToggles(complition: (() -> Void)?)
}

final class FeatureToggleService: FeatureToggleServiceProtocol {
	private let provider: FeatureToggleProvider
	private var featureToggles: [FeatureToggle] = []

	init(_ provider: FeatureToggleProvider) {
		self.provider = provider
	}

	func isEnabled(_ feature: Feature) -> Bool {
		let feature = featureToggles.first(where: { $0.feature == feature })
		return feature?.enabled ?? false
	}

	func fetchToggles(complition: (() -> Void)? = nil) {
		provider.fetchFeatureToggles { [weak self] featureToggles in
			self?.featureToggles = featureToggles
			complition?()
		}
	}
}
