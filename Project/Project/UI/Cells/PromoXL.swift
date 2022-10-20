//
//  PromoXL.swift
//  Project
//
//  Created by Улько Артем Викторович on 20.10.2022.
//

import UIKit

final class PromoXLCell: UICollectionViewCell {
	static let identifier = "PromoXLCell"

	private let collectionView: UICollectionView = {
		let layout = UICollectionViewFlowLayout()
		layout.scrollDirection = .horizontal
		let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
		collection.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
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
		return 10
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
		let imageView = UIImageView()
		imageView.image = UIImage(named: "duff")
		imageView.contentMode = .scaleAspectFill
		cell.addSubview(imageView)
		cell.layer.cornerRadius = 8
		cell.clipsToBounds = true
		imageView.fillSuperview()

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
