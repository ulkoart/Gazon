//
//  LocalFeatureToggleProvider.swift
//  Project
//
//  Created by Улько Артем Викторович on 29.08.2022.
//

import Foundation

/// Провайдер локальный тоглов
struct LocalFeatureToggleProvider: FeatureToggleProvider {
	func fetchFeatureToggles(_ completion: @escaping ([FeatureToggle]) -> Void) {
		let decoder = PropertyListDecoder()

		guard
			let localTogglesData = Bundle.main.url(forResource: "Toggles", withExtension: "plist"),
			let togglesData = try? Data(contentsOf: localTogglesData),
			let featureToggles = try? decoder.decode([FeatureToggle].self, from: togglesData)
		else {
			completion([])
			return
		}
		completion(featureToggles)
	}
}
