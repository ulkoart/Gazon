//
//  IdentifierCell.swift
//  Project
//
//  Created by Улько Артем Викторович on 22.08.2022.
//

import Foundation

protocol IdentifierCell {
	static var identifier: String { get }
}

extension IdentifierCell {
	static var identifier: String { String(describing: self) }
}
