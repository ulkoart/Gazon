//
//  HomeBoardController.swift
//  Project
//
//  Created by user on 12.08.2022.
//

import UIKit
import Combine

final class HomeController: BaseController {

	private var cancellables: Set<AnyCancellable> = []
	var viewModel: HomeViewModel?
	var coordinator: HomeFlow?

	private let collectionView: UICollectionView = {
		let layout = UICollectionViewFlowLayout()
		layout.scrollDirection = .vertical
		let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
		collection.register(HomeItemCell.self, forCellWithReuseIdentifier: HomeItemCell.identifier)
		collection.register(PromoXLCell.self, forCellWithReuseIdentifier: PromoXLCell.identifier)
		collection.translatesAutoresizingMaskIntoConstraints = false
		collection.showsVerticalScrollIndicator = false
		collection.isPagingEnabled = false
		collection.contentInset = UIEdgeInsets(top: 16, left: 0, bottom: 0, right: 0)
		return collection
	}()

	convenience init() {
		self.init(viewModel: nil)
	}

	init(viewModel: HomeViewModel?) {
		self.viewModel = viewModel
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		setup()
		bindViewModel()
		self.viewModel?.retrieveData()
	}

	private func setup() {
		view.backgroundColor = .almond
		addInfoButton()
		view.addSubview(collectionView)
		collectionView.fillSuperview()
		collectionView.backgroundColor = .clear
		collectionView.delegate = self
		collectionView.dataSource = self
	}

	private func addInfoButton() {
		let infoButton = UIBarButtonItem(
					image: UIImage(systemName: "info.circle"),
					style: .plain,
					target: self, action: #selector(infoButtonTapped)
		)
		navigationItem.rightBarButtonItems = [infoButton]
	}

	private func bindViewModel() {

		viewModel?.isLoadingPublisher
			.receive(on: DispatchQueue.main)
			.sink { [weak self] isLoading in
				self?.collectionView.reloadData()
				self?.activityIndicator.isHidden = !isLoading
				self?.collectionView.isHidden = isLoading
			}
			.store(in: &cancellables)
	}

    @objc private func infoButtonTapped() {
        coordinator?.coordinateToInfo()
    }
}

extension HomeController: UICollectionViewDelegate {}

extension HomeController: UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return viewModel?.blocksCount ?? 0
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		switch indexPath.item {
		case 0:
			let cell = collectionView.dequeueReusableCell(
				withReuseIdentifier: HomeItemCell.identifier, for: indexPath
			) as? HomeItemCell
			guard let cell = cell else { return UICollectionViewCell() }
			cell.setupWithCode(viewModel?.code)
			return cell

		case 1:
			let cell = collectionView.dequeueReusableCell(
				withReuseIdentifier: PromoXLCell.identifier, for: indexPath
			) as? PromoXLCell
			guard let cell = cell else { return UICollectionViewCell() }
			cell.numberOfBanners = viewModel?.numberOfXLBanners ?? 0
			return cell

		default:
			return UICollectionViewCell()
		}
	}
}

extension HomeController: UICollectionViewDelegateFlowLayout {
	func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {

		if indexPath.item == 0 {
			return .init(width: view.frame.width - Spacing.sizeS * 2, height: 80)
		} else if indexPath.item == 1 {
			return .init(width: view.frame.width, height: 200)
		}
		return .init(width: 0, height: 0)
	}
}
