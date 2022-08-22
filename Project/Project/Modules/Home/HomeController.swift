//
//  HomeBoardController.swift
//  Project
//
//  Created by user on 12.08.2022.
//

import UIKit
import Combine

final class HomeController: UIViewController {

	private var cancellables: Set<AnyCancellable> = []
	var viewModel: HomeViewModel?
	var coordinator: HomeFlow?

	private let collectionView: UICollectionView = {
		let layout = UICollectionViewFlowLayout()
		layout.scrollDirection = .vertical
		let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
		collection.register(HomeItemCell.self, forCellWithReuseIdentifier: HomeItemCell.identifier)
		collection.translatesAutoresizingMaskIntoConstraints = false
		collection.showsVerticalScrollIndicator = false
		collection.isPagingEnabled = false
		collection.contentInset = UIEdgeInsets(top: 16, left: 0, bottom: 0, right: 0)
		return collection
	}()

	private let activityIndicator: UIActivityIndicatorView = {
		$0.style = .large
		$0.startAnimating()
		$0.hidesWhenStopped = true
		return $0
	}(UIActivityIndicatorView())

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
		view.backgroundColor = UIColor(white: 0.95, alpha: 1)
		addInfoButton()

		view.addSubview(collectionView)
		collectionView.fillSuperview()
		collectionView.backgroundColor = .clear
		collectionView.delegate = self
		collectionView.dataSource = self

		view.addSubview(activityIndicator)
		activityIndicator.centerInSuperview()
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

		viewModel?.itemsPublisher
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

    @objc private func infoButtonTapped() {
        coordinator?.coordinateToInfo()
    }
}

extension HomeController: UICollectionViewDelegate {}

extension HomeController: UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return viewModel?.itemsCount ?? 0
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeItemCell.identifier, for: indexPath)
		return cell
	}
}

extension HomeController: UICollectionViewDelegateFlowLayout {
	func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
		return .init(width: view.frame.width - 32, height: 100)
	}
}
