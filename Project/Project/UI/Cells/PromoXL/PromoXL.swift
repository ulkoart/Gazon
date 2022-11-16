//
//  PromoXL.swift
//  Project
//
//  Created by Улько Артем Викторович on 20.10.2022.
//

import UIKit

final class PromoXLCell: UICollectionViewCell {
	static let identifier = "PromoXLCell"

	var numberOfBanners = 0 {
		didSet {
			self.collectionView.reloadData()
		}
	}

	private let collectionView: UICollectionView = {
		let layout = UICollectionViewFlowLayout()
		layout.scrollDirection = .horizontal
		let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
		collection.register(PromoXLItemCell.self, forCellWithReuseIdentifier: PromoXLItemCell.identifier)
		collection.translatesAutoresizingMaskIntoConstraints = false
		collection.showsHorizontalScrollIndicator = false
		collection.isPagingEnabled = true
		return collection
	}()

	override init(frame: CGRect) {
		super.init(frame: frame)

		addSubview(collectionView)
		collectionView.fillSuperview()
		collectionView.backgroundColor = .clear
		collectionView.delegate = self
		collectionView.dataSource = self
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

extension PromoXLCell: UICollectionViewDelegate {
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {}
}

extension PromoXLCell: UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return numberOfBanners
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard
			let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PromoXLItemCell.identifier, for: indexPath) as? PromoXLItemCell
		else { fatalError() } // TODO: - подумать что тут лучше сделать

		cell.setup(with: UIImage(named: "duff"))
		return cell
	}
}

extension PromoXLCell: UICollectionViewDelegateFlowLayout {
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
		return 16
	}

	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		return CGSize(width: frame.size.width - 16, height: frame.size.height - 16)
	}

	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
		return UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
	}
}
