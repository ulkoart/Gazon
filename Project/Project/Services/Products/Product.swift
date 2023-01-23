//
//  Product.swift
//  Project
//
//  Created by Улько Артем Викторович on 20.10.2022.
//

import Foundation

struct Product: Codable {
	let id: String
	let title: String

	enum CodingKeys: String, CodingKey {
		case id, title
	}
}

