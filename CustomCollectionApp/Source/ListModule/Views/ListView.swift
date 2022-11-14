//
//  ListView.swift
//  CustomCollectionApp
//
//  Created by Nikita Kirshin on 13.11.2022.
//

import UIKit

protocol DisplaysListView {
    func configure(with viewModel: ListDataFlow.PresentationCollectionView.ViewModel)
}

final class ListView: UIView {
    
    private let collectionManager: ManageListCollection

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.register(ListViewCell.self, forCellWithReuseIdentifier: Constants.identifier)
        collection.backgroundColor = .white
        collection.showsHorizontalScrollIndicator = false
        collection.dataSource = collectionManager
        collection.delegate = collectionManager
        
        return collection
    }()
    
    // MARK: - Lifecycle
    
    init(collectionManager: ManageListCollection) {
        self.collectionManager = collectionManager
        super.init(frame: .zero)
        collectionManager.delegate = self
        addSubviews()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ListView: DisplaysListView {
    func configure(with viewModel: ListDataFlow.PresentationCollectionView.ViewModel) {
        collectionManager.cells = viewModel.cells
        collectionView.reloadData()
    }
}

extension ListView: ListCollectionManagerDelegate {
    
}

private extension ListView {
    func addSubviews() {
        self.addSubview(collectionView)
    }
    
    func configureConstraints() {
        makeCollectionViewConstraints()
    }
    
    func makeCollectionViewConstraints() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        var constraints = [NSLayoutConstraint]()
        constraints.append(collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor))
        constraints.append(collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor))
        constraints.append(collectionView.topAnchor.constraint(equalTo: self.topAnchor))
        constraints.append(collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor))

        NSLayoutConstraint.activate(constraints)
    }
}

private extension ListView {
    private enum Constants {
        static let identifier = "ListCollectionViewCell"
    }
}

