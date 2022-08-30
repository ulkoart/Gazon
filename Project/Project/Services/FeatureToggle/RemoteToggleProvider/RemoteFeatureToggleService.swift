//
//  RemoteFeatureToggleService.swift
//  Project
//
//  Created by Улько Артем Викторович on 29.08.2022.
//

import Foundation

enum RemoteFeatureToggleService {
	case toggles
}

extension RemoteFeatureToggleService: ApiService {
	var baseURL: String {
		"https://62fc868bb9e38585cd408802.mockapi.io"
	}
	
	var path: String {
		switch self {
		case .toggles:
			return "/toggles"
		}
	}
	
	var parameters: [String : Any]? {
		nil
	}
	
	var method: ApiServiceMethod {
		.get
	}
}
