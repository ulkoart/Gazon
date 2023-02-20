//
//  ApiServiceProvider.swift
//  Project
//
//  Created by Улько Артем Викторович on 19.08.2022.
//
// Лишнии сообщения в консоли
// https://stackoverflow.com/questions/44410572/failed-to-register-for-boringssl-log-debug-updates
// xcrun simctl spawn booted log config --subsystem com.apple.network --category boringssl --mode "level:off"

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
				completion(.failure(error))
			}
		}
	}
}

extension ApiServiceProvider {
	private func call(
		_ request: URLRequest,
		deliverQueue: DispatchQueue = DispatchQueue.main,
		completion: @escaping (Result<Data, Error>) -> Void) {
			let task = urlSession.dataTask(with: request) { (data, response, error) in
				if let error = error {
					deliverQueue.async {
						Log.error("📶 - Ошибка запроса к сети", shouldLogContext: false)
						completion(.failure(error))
					}
				} else {
					guard
						let data = data,
						let response = response as? HTTPURLResponse,
						let url = response.url
					else {
						completion(.failure(NetworkError.noData))
						return
					}

					Logger.shared.log("📶 - запрос выполнен \n          URL: \(url) \n          Код ответа: \(response.statusCode)")
					completion(.success(data))
				}
			}
			task.resume()
		}
}
