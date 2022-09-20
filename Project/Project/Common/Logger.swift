//
//  Logger.swift
//  Project
//
//  Created by Улько Артем Викторович on 13.09.2022.
//

import Foundation

protocol LoggerProtocol {
	func log(_ item: String)
}

class Logger: LoggerProtocol {

	static let shared: LoggerProtocol = Logger()

	private init() {}

	func log(_ item: String) {
		print("➡️ - \(item)")
	}
}
