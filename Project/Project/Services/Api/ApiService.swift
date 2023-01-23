//
//  ApiService.swift
//  Project
//
//  Created by Улько Артем Викторович on 19.08.2022.
//

import Foundation

enum ApiServiceMethod: String {
	case get = "GET"
	case post = "POST"
	case put = "PUT"
	case patch = "PATCH"
	case delete  = "DELETE"
}

protocol ApiService {
	var baseURL: String { get }
	var path: String { get }
	var parameters: [String: Any]? { get }
	var method: ApiServiceMethod { get }
}

extension ApiService {
	private var url: URL? {
		var urlComponents = URLComponents(string: baseURL)
		urlComponents?.path = path
		guard let parameters = parameters else { return urlComponents?.url }

		if method == .get {
			guard let parameters = parameters as? [String: String] else {
				fatalError("Параметры должны быть [String: String]")
			}
			urlComponents?.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
		}

		return urlComponents?.url
	}

	var urlRequest: URLRequest {
		guard let url = self.url else {
			fatalError("Ошибка создания URL")
		}
		var request = URLRequest(url: url)
		request.httpMethod = method.rawValue

		return request
	}
}
