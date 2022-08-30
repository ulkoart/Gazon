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
	private let localFeatureToggleService: FeatureToggleService
	private let remoteFeatureToggleService: FeatureToggleService

	init(complition: @escaping () -> Void) {
		let localProvider = LocalFeatureToggleProvider()
		let remoteProvider = RemoteFeatureToggleProvider()

		self.localFeatureToggleService = FeatureToggleService(localProvider)
		self.remoteFeatureToggleService = FeatureToggleService(remoteProvider)

		self.localFeatureToggleService.fetchToggles()

		self.remoteFeatureToggleService.fetchToggles {
			complition()
		}
	}
}

extension FeatureToggleFacade: FeatureToggleFacadeProtocol {
	var isHomeScreenInfoButtonEnabled: Bool {
		localFeatureToggleService.isEnabled(.homeScreenInfoButton) &&
		remoteFeatureToggleService.isEnabled(.homeScreenInfoButton)
	}
}
