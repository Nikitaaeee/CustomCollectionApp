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
    var router: ListRoutes?
    
    // MARK: - Views
    
    private lazy var contentView: DisplaysListView = ListView(collectionManager: ListCollectionManager())
    private lazy var rightBarButton: UIBarButtonItem = {
        let button = UIBarButtonItem()
        button.image = UIImage(systemName: Constants.refreshButtonImage)
        button.style = .plain
        button.target = self
        button.action = #selector(barButtonPressed)
        
        return button
    }()
    
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
        addConnectionObserver()
        configureNavigationBar()
    }
}

// MARK: - Private

private extension ListViewController {
    func configureNavigationBar() {
        navigationItem.rightBarButtonItem = rightBarButton
        self.title = Constants.navBarTitle
    }
    
    func addConnectionObserver() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.showOfflineDeviceUI(notification:)),
                                               name: NSNotification.Name.connectivityStatus,
                                               object: nil)
    }
    
    @objc
    func showOfflineDeviceUI(notification: Notification) {
        if !NetworkMonitor.shared.isConnected {
            DispatchQueue.main.async {
                self.router?.didRequestAlert(title: Constants.noConnectionTitle,
                                             message: Constants.noConnectionMessage)
            }
        }
    }
    
    @objc
    func barButtonPressed() {
        interactor?.refreshData()
    }
}

    // MARK: - ListViewDisplayLogic

extension ListViewController: ListViewDisplayLogic {
    func displayEmployeeData(with viewModel: ListDataFlow.PresentationCollectionView.ViewModel) {
        contentView.configure(with: viewModel)
    }
}

private extension ListViewController {
    enum Constants {
        static let refreshButtonImage: String = "arrow.clockwise.icloud.fill"
        static let noConnectionTitle: String = "No Internet Connection"
        static let noConnectionMessage: String = "Make Sure Your Device Connected To Internet"
        static let navBarTitle: String = "Avito"
    }
}
