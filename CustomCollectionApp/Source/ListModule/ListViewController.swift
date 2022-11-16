//
//  CustomCollectionViewController.swift
//  CustomCollectionApp
//
//  Created by Nikita Kirshin on 13.11.2022.
//

import UIKit

protocol ListViewDisplayLogic: AnyObject {
    func displayEmployeeData(with viewModel: ListDataFlow.PresentationCollectionView.ViewModel)
}

final class ListViewController: UIViewController {
    
    // MARK: - Properties

    var interactor: ListBussinesLogic?

    // MARK: - Views
    
    private lazy var contentView: DisplaysListView = ListView(collectionManager: ListCollectionManager())
    
    // MARK: - Lifecycle
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = contentView as? UIView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        interactor?.fetchData()
    }
}

    // MARK: - ListViewDisplayLogic

extension ListViewController: ListViewDisplayLogic {
    func displayEmployeeData(with viewModel: ListDataFlow.PresentationCollectionView.ViewModel) {
        contentView.configure(with: viewModel)
    }
}
