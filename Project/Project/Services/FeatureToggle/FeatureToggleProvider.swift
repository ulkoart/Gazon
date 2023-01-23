//
//  FeatureToggleProvider.swift
//  Project
//
//  Created by Улько Артем Викторович on 29.08.2022.
//

import Foundation

/// FeatureToggleProvider протокол для провайдера фиче-тоглов, должен отдавать в замыкание список фиче-тоглов
protocol FeatureToggleProvider {
	func fetchFeatureToggles(_ completion: @escaping ([FeatureToggle]) -> Void)
}
