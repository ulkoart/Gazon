//
//  FeatureToggle.swift
//  Project
//
//  Created by Улько Артем Викторович on 29.08.2022.
//

import Foundation

struct FeatureToggle: Decodable {
	let feature: Feature
	let enabled: Bool

	enum CodingKeys: String, CodingKey {
		case feature
		case enabled
	}
}
