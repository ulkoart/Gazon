//
//  HomeItemCell.swift
//  Project
//
//  Created by Улько Артем Викторович on 17.08.2022.
//

import UIKit

final class HomeItemCell: UICollectionViewCell {
	static let identifier = "HomeItemCell"

	private let titleLabel: UILabel = {
		$0.translatesAutoresizingMaskIntoConstraints = false
		$0.font = .init(.systemFont(ofSize: 12, weight: .medium))
		$0.textColor = .systemGreen
		$0.text = "QR КОД ДОСТАВКИ"
		return $0
	}(UILabel())

	private let textLabel: UILabel = {
		$0.translatesAutoresizingMaskIntoConstraints = false
		$0.font = .init(.systemFont(ofSize: 12, weight: .medium))
		$0.textColor = .black
		$0.text = "Покажите этот код"
		return $0
	}(UILabel())
	
	private let codeLabel: UILabel = {
		$0.translatesAutoresizingMaskIntoConstraints = false
		$0.font = .init(.systemFont(ofSize: 12, weight: .bold))
		$0.textColor = .black
		$0.text = "748"
		return $0
	}(UILabel())

	private let qrCode: UIImageView = {
		$0.translatesAutoresizingMaskIntoConstraints = false
		$0.image = UIImage(named: "qr-code")
		return $0
	}(UIImageView())

	override init(frame: CGRect) {
		super.init(frame: frame)
		backgroundColor = .white

		layer.cornerRadius = 8
		layer.shadowRadius = 5.0
		layer.shadowColor = UIColor.black.cgColor
		layer.shadowOpacity = 0.10
		layer.shadowOffset = CGSize(width: 0, height: 5)
	
		addSubview(titleLabel)
		NSLayoutConstraint.activate([
			titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
			titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8)
		])

		addSubview(textLabel)
		NSLayoutConstraint.activate([
			textLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
			textLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8)
		])

		addSubview(codeLabel)
		NSLayoutConstraint.activate([
			codeLabel.leadingAnchor.constraint(equalTo: textLabel.trailingAnchor, constant: 4),
			codeLabel.bottomAnchor.constraint(equalTo: textLabel.bottomAnchor),

		])

		addSubview(qrCode)
		NSLayoutConstraint.activate([
			qrCode.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
			qrCode.centerYAnchor.constraint(equalTo: centerYAnchor),
			qrCode.heightAnchor.constraint(equalToConstant: 70),
			qrCode.widthAnchor.constraint(equalToConstant: 70)
		])
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
