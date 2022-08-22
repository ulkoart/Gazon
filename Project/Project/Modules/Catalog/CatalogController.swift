//
//  ViewController.swift
//  Project
//
//  Created by user on 11.08.2022.
//

import UIKit

final class CatalogController: UIViewController {

	var viewModel: CatalogViewModel?

	private let collectionView: UICollectionView = {
		let layout = UICollectionViewFlowLayout()
		layout.scrollDirection = .vertical
		let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
		collection.register(ProductCell.self, forCellWithReuseIdentifier: ProductCell.identifier)
		collection.translatesAutoresizingMaskIntoConstraints = false
		collection.showsVerticalScrollIndicator = false
		collection.isPagingEnabled = false
		return collection
	}()

    override func viewDidLoad() {
        super.viewDidLoad()
		setup()
    }

	private func setup() {
		view.backgroundColor = UIColor(white: 0.98, alpha: 1)

		view.addSubview(collectionView)
		collectionView.fillSuperview()
		collectionView.backgroundColor = .clear
		collectionView.delegate = self
		collectionView.dataSource = self
	}
}

extension CatalogController: UICollectionViewDelegate {}

extension CatalogController: UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return viewModel?.numberOfItemsInSection ?? 0
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCell.identifier, for: indexPath)
		return cell
	}
}

extension CatalogController: UICollectionViewDelegateFlowLayout {
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		let width = (view.frame.width - 3 * 16) / 2
		return .init(width: width, height: width * 1.5)
	}

	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
		return UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
		return 16
	}
}
