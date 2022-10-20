//
//  ViewController.swift
//  Project
//
//  Created by user on 11.08.2022.
//

import UIKit
import Combine

final class CatalogController: BaseController {

	private var cancellables: Set<AnyCancellable> = []

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
		bindViewModel()
		self.viewModel?.retrieveData()
	}

	private func setup() {
		view.backgroundColor = .almond
		view.addSubview(collectionView)
		collectionView.fillSuperview()
		collectionView.backgroundColor = .clear
		collectionView.delegate = self
		collectionView.dataSource = self
	}

	private func bindViewModel() {
		viewModel?.productsPublisher
			.receive(on: DispatchQueue.main)
			.sink { [weak self] items in
				if !items.isEmpty {
					self?.collectionView.reloadData()
					self?.activityIndicator.stopAnimating()
				}
			}
			.store(in: &cancellables)

		viewModel?.isLoadingPublisher
			.receive(on: DispatchQueue.main)
			.sink { [weak self] isLoading in
				self?.activityIndicator.isHidden = !isLoading
			}
			.store(in: &cancellables)
	}
}

extension CatalogController: UICollectionViewDelegate {}

extension CatalogController: UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return viewModel?.productsCount ?? 0
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCell.identifier, for: indexPath)
		return cell
	}
}

extension CatalogController: UICollectionViewDelegateFlowLayout {
	func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
		let width = (view.frame.width - 3 * 16) / 2
		return .init(width: width, height: width * 1.5)
	}

	func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
		return UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
	}

	func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
		return 16
	}
}
