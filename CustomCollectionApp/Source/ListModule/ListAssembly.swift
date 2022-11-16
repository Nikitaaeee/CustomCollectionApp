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
        let networkManager = ListNetworkManager()
        let employeeStorage = EmployeeStorage()
        let provider = EmployeeListProvider(networkManager: networkManager,
                                            employeStorage: employeeStorage)
        let interactor = ListInteractor(provider: provider)
        let presenter = ListPresenter()
        viewController.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = viewController

        return viewController
    }
}
