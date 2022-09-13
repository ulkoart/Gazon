//
//  JPHService.swift
//  Project
//
//  Created by Улько Артем Викторович on 19.08.2022.
//

import Foundation

enum ProductsService {
	case products
	case productDetaild(id: String)
}

extension ProductsService: ApiService {
	var baseURL: String {
		"https://62fc868bb9e38585cd408802.mockapi.io"
	}

	var path: String {
		switch self {
		case .products:
			return "/products"
		case .productDetaild(let id):
			return "/products/\(id)"
		}
	}

	var parameters: [String: Any]? {
		return nil
	}

	var method: ApiServiceMethod {
		return .get
	}
}

struct Product: Codable {
	let id: String
	let title: String

	enum CodingKeys: String, CodingKey {
		case id, title
	}
}
