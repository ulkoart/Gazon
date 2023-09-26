//
//  AdvertisingService.swift
//  Project
//
//  Created by Улько Артем Викторович on 20.02.2023.
//
// https://run.mocky.io/v3/2a8e1bb7-5d74-4017-8dc6-75a39f1a4f19
// https://designer.mocky.io/manage/delete/2a8e1bb7-5d74-4017-8dc6-75a39f1a4f19/XMb2c8lzehZZOaWY8OoJKhO4OvDvA2S9q3wU

import Foundation

enum AdvertisingService {
	case homeSrceen(userID: String?)
}

extension AdvertisingService: ApiService {
	var baseURL: String {
		"https://run.mocky.io"
	}

	var path: String {
		switch self {
		case .homeSrceen(let userID):
			return "/v3/\(userID ?? "")"
		}
	}

	var parameters: [String: Any]? {
		nil
	}

	var method: ApiServiceMethod {
		.get
	}
}

struct AdvertisingHome: Codable {
	let numberOfXLBanners: Int
}
