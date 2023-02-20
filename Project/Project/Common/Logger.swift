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

@available(*, deprecated, message: "Устарело, нужно использовать новый логгер Log")
class Logger: LoggerProtocol {

	static let shared: LoggerProtocol = Logger()

	private init() {}

	func log(_ item: String) {
		#if DEBUG
		print("➡️ - \(item)")
		#endif
	}
}

enum Log {
	enum LogLevel {
		case info
		case warning
		case error

		fileprivate var prefix: String {
			switch self {
			case .info:
				return "ℹ️"
			case .warning:
				return "⚠️"
			case .error:
				return "🧨"
			}
		}
	}

	struct Context {
		let file: String
		let function: String
		let line: Int
		var description: String {
			return "\((file as NSString).lastPathComponent):\(line) \(function)"
		}
	}

	static func info(
		_ str: String,
		shouldLogContext: Bool = true,
		file: String = #file,
		function: String = #function,
		line: Int = #line
	) {
		let context = Context(file: file, function: function, line: line)
		Log.handleLog(level: .info, str: str, shouldLogContext: shouldLogContext, context: context)
	}

	static func warning(
		_ str: String,
		shouldLogContext: Bool = true,
		file: String = #file,
		function: String = #function,
		line: Int = #line
	) {
		let context = Context(file: file, function: function, line: line)
		Log.handleLog(level: .warning, str: str.description, shouldLogContext: shouldLogContext, context: context)
	}

	static func error(
		_ str: String,
		shouldLogContext: Bool = true,
		file: String = #file,
		function: String = #function,
		line: Int = #line
	) {
		let context = Context(file: file, function: function, line: line)
		Log.handleLog(level: .error, str: str.description, shouldLogContext: shouldLogContext, context: context)
	}

	fileprivate static func handleLog(level: LogLevel, str: String, shouldLogContext: Bool, context: Context) {
		let logComponents = ["\(level.prefix) -", str]

		var fullString = logComponents.joined(separator: " ")
		if shouldLogContext {
			fullString += " 📝 \(context.description)"
		}

#if DEBUG
		print(fullString)
#endif
	}
}
