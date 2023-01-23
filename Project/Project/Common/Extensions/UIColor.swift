//
//  UIColor.swift
//  Project
//
//  Created by Улько Артем Викторович on 31.08.2022.
//

import UIKit

extension UIColor {
	public convenience init?(hex: String) {

        // swiftlint:disable identifier_name
		let r, g, b, a: CGFloat

		if hex.hasPrefix("#") {
			let start = hex.index(hex.startIndex, offsetBy: 1)
			let hexColor = String(hex[start...])

			if hexColor.count == 8 {
				let scanner = Scanner(string: hexColor)
				var hexNumber: UInt64 = 0

				if scanner.scanHexInt64(&hexNumber) {
					r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
					g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
					b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
					a = CGFloat(hexNumber & 0x000000ff) / 255

					self.init(red: r, green: g, blue: b, alpha: a)
					return
				}
			}
		}

		return nil
	}
}

extension UIColor {
	static let navy = UIColor(hex: "#1e3d59ff")
	static let almond = UIColor(hex: "#f5f0e1ff")
	static let redOrange = UIColor(hex: "#ff6e40ff")
	static let mango = UIColor(hex: "#ffc13bff")
}
