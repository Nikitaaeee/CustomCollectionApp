//
//  ListViewAssembly.swift
//  CustomCollectionApp
//
//  Created by Nikita Kirshin on 13.11.2022.
//

import Foundation

struct ListViewAssembly: ModuleAssembly {
    typealias Context = Any?
    typealias ViewController = ListViewController

    func build(with _: Any?) throws -> ViewController {
        let viewController = ListViewController()
        let networkService = ListNetworkManager()
        let provider = EmployeeListProvider(networkService: networkService)
        let interactor = ListInteractor(provider: provider)
        let presenter = ListPresenter()
        viewController.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = viewController

        return viewController
    }
}
