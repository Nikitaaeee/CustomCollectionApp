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
    
    var presenter: ListPresentationLigic?
    var provider: ProvidesEmployeeData?
    
    init(provider: ProvidesEmployeeData) {
        self.provider = provider
    }
}

extension ListInteractor: ListBussinesLogic {
    func fetchData() {
        provider?.fetchData(complition: { [weak self] list in
            guard
                let self = self,
                let list = list
            else {
                return
            }
            self.fetchViewModel(list: list.company)
        })
    }
}

private extension ListInteractor {
    
    func fetchViewModel(list: Company) {
        let model = ListDataFlow.PresentationCollectionView.Response.init(employees: list.employees)
        presenter?.presentData(response: model)
    }
}
