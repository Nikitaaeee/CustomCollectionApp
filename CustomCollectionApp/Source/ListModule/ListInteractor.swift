//
//  ListViewInteractor.swift
//  CustomCollectionApp
//
//  Created by Nikita Kirshin on 13.11.2022.
//

import Foundation

protocol ListBussinesLogic: AnyObject {
    func fetchData()
}

final class ListInteractor {
    
    // MARK: - Properties
    
    var presenter: ListPresentationLigic?
    var provider: ProvidesEmployeeData?
    
    // MARK: - Lifecycle

    init(provider: ProvidesEmployeeData) {
        self.provider = provider
    }
}

    // MARK: - ListBussinesLogic

extension ListInteractor: ListBussinesLogic {
    func fetchData() {
        provider?.fetchData(completion: { [weak self] list in
            guard
                let self = self,
                let list = list
            else {
                return
            }
            self.fetchViewModel(list: list)
        })
    }
}

    // MARK: - Private

private extension ListInteractor {
    func fetchViewModel(list: [Employee]) {
        let model = ListDataFlow.PresentationCollectionView.Response.init(employees: list)
        presenter?.presentData(response: model)
    }
}
