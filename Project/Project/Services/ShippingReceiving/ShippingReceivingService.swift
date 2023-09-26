//
//  ShippingReceivingService.swift
//  Project
//
//  Created by Улько Артем Викторович on 20.10.2022.
//

import Foundation

enum ShippingReceivingService {
	case deliveryCode(userID: String)
}

extension ShippingReceivingService: ApiService {
	var baseURL: String {
		"https://62fc868bb9e38585cd408802.mockapi.io"
	}

	var path: String {
		switch self {
		case .deliveryCode(userID: let userID):
			return "/deliveryCode/\(userID)"
		}
	}

	var parameters: [String: Any]? {
		return nil
	}

	var method: ApiServiceMethod {
		.get
	}
}

struct DeliveryCode: Codable {
	let id: String
	let code: String

	enum CodingKeys: String, CodingKey {
		case id, code
	}
}
