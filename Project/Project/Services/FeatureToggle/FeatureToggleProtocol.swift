//
//  FeatureToggleProtocol.swift
//  Project
//
//  Created by Улько Артем Викторович on 19.09.2022.
//

import Foundation

protocol FeatureToggleProtocol {
	func isEnabled(_ feature: Feature) -> Bool
}
