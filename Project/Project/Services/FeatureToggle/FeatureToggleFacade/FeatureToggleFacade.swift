//
//  FeatureToggleFacade.swift
//  Project
//
//  Created by Улько Артем Викторович on 29.08.2022.
//

import Foundation

protocol FeatureToggleFacadeProtocol {
	var isHomeScreenInfoButtonEnabled: Bool { get }
}

final class FeatureToggleFacade {
	private let localFeatureToggle: FeatureToggleProtocol
	private let remoteFeatureToggle: FeatureToggleProtocol

	init(localFeatureToggle: FeatureToggleProtocol, remoteFeatureToggle: FeatureToggleProtocol) {
		self.localFeatureToggle = localFeatureToggle
		self.remoteFeatureToggle = remoteFeatureToggle
	}
}

extension FeatureToggleFacade: FeatureToggleFacadeProtocol {
	var isHomeScreenInfoButtonEnabled: Bool {
		localFeatureToggle.isEnabled(.homeScreenInfoButton) &&
		remoteFeatureToggle.isEnabled(.homeScreenInfoButton)
	}
}
