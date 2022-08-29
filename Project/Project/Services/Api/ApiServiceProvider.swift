//
//  ApiServiceProvider.swift
//  Project
//
//  Created by Улько Артем Викторович on 19.08.2022.
//

import Foundation

enum NetworkError: Error {
	case noData
	case parseDataError
}

final class ApiServiceProvider<T: ApiService> {
	private let urlSession: URLSession = URLSession(configuration: URLSessionConfiguration.default)
	private let decoder: JSONDecoder = JSONDecoder()
	
	func load(service: T, completion: @escaping (Result<Data, Error>) -> Void) {
		call(service.urlRequest, completion: completion)
	}
	
	func load<U>(service: T, decodeType: U.Type, completion: @escaping (Result<U, Error>) -> Void) where U: Decodable {
		call(service.urlRequest) { result in
			switch result {
			case let .success(data):
				guard
					let response = try? self.decoder.decode(decodeType, from: data)
				else {
					completion(.failure(NetworkError.parseDataError))
					return
				}
				completion(.success(response))
			case let .failure(error):
				// TODO: обрабатывать ошибки
				print(error)
			}
		}
	}
}

extension ApiServiceProvider {
	private func call(
		_ request: URLRequest,
		deliverQueue: DispatchQueue = DispatchQueue.main,
		completion: @escaping (Result<Data, Error>) -> Void) {
			let task = urlSession.dataTask(with: request) { (data, _, error) in
				if let error = error {
					deliverQueue.async {
						completion(.failure(error))
					}
				}

				guard
					let data = data
				else {
					completion(.failure(NetworkError.noData))
					return
				}

				completion(.success(data))
			}
			task.resume()
		}
}
