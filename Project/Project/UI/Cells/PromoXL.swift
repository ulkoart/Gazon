//
//  PromoXL.swift
//  Project
//
//  Created by Улько Артем Викторович on 20.10.2022.
//

import UIKit

final class PromoXLCell: UICollectionViewCell {
	static let identifier = "PromoXLCell"

	override init(frame: CGRect) {
		super.init(frame: frame)
		backgroundColor = .blue
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
