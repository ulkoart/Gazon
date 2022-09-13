//
//  ProductCell.swift
//  Project
//
//  Created by Улько Артем Викторович on 22.08.2022.
//

import UIKit

final class ProductCell: UICollectionViewCell {

	override var isHighlighted: Bool {
		didSet {
			var transform: CGAffineTransform = .identity

			if isHighlighted {
				transform = .init(scaleX: 0.95, y: 0.95)
			}

			UIView.animate(
                withDuration: 0.3,
                delay: 0,
                usingSpringWithDamping: 1,
                initialSpringVelocity: 1,
                options: .curveEaseOut) {
				self.transform = transform
			}
		}
	}

	private let priceLabel: UILabel = {
		$0.translatesAutoresizingMaskIntoConstraints = false
		$0.font = .init(.systemFont(ofSize: 12, weight: .bold))
		$0.textColor = .navy
		$0.text = "3 168 ₽"
		return $0
	}(UILabel())

	private let titleLabel: UILabel = {
		$0.translatesAutoresizingMaskIntoConstraints = false
		$0.font = .init(.systemFont(ofSize: 12, weight: .regular))
		$0.textColor = .navy
		$0.text = "Пиво \"Duff\""
		return $0
	}(UILabel())

	private let producImage: UIImageView = {
		$0.translatesAutoresizingMaskIntoConstraints = false
		$0.image = UIImage(named: "duff")
		$0.contentMode = .scaleAspectFill
		$0.clipsToBounds = true
		$0.layer.cornerRadius = 8
		return $0
	}(UIImageView())

	override init(frame: CGRect) {
		super.init(frame: frame)
		setup()

	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	private func setup() {
		backgroundColor = .clear

		addSubview(titleLabel)
		NSLayoutConstraint.activate([
			titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4),
			titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4)
		])

		addSubview(priceLabel)
		NSLayoutConstraint.activate([
			priceLabel.bottomAnchor.constraint(equalTo: titleLabel.topAnchor, constant: -2),
			priceLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4)
		])

		addSubview(producImage)
		NSLayoutConstraint.activate([
			producImage.bottomAnchor.constraint(equalTo: priceLabel.topAnchor, constant: -4),
			producImage.leadingAnchor.constraint(equalTo: leadingAnchor),
			producImage.trailingAnchor.constraint(equalTo: trailingAnchor),
			producImage.topAnchor.constraint(equalTo: topAnchor)
		])
	}
}

extension ProductCell: IdentifierCell {}
