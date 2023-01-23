//
//  PromoXLItem.swift
//  Project
//
//  Created by Улько Артем Викторович on 16.11.2022.
//

import UIKit

final class PromoXLItemCell: UICollectionViewCell {
	static let identifier = "PromoXLItemCell"

	func setup(with image: UIImage?) {
		let imageView = UIImageView()
		imageView.image = image
		imageView.contentMode = .scaleAspectFill
		addSubview(imageView)
		layer.cornerRadius = 8
		clipsToBounds = true
		imageView.fillSuperview()
	}
}
