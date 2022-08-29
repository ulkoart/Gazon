//
//  JPHService.swift
//  Project
//
//  Created by Улько Артем Викторович on 19.08.2022.
//

import Foundation

enum JPHService {
	case todos
	case todo(id: String)
}

extension JPHService: ApiService {
	var baseURL: String {
		"https://jsonplaceholder.typicode.com"
	}

	var path: String {
		switch self {
		case .todos:
			return "/todos/"
		case .todo(let id):
			return "/todos/\(id)"
		}
	}

	var parameters: [String: Any]? {
		return nil
	}

	var method: ApiServiceMethod {
		return .get
	}
}

struct Item: Codable {
	let userID, id: Int
	let title: String
	let completed: Bool

	enum CodingKeys: String, CodingKey {
		case userID = "userId"
		case id, title, completed
	}
}
