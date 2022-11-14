//
//  ListProvider.swift
//  CustomCollectionApp
//
//  Created by Nikita Kirshin on 13.11.2022.
//

import Foundation

protocol ProvidesEmployeeData: AnyObject {
    func fetchData(complition: @escaping (DTOModel?) -> Void)
}

final class EmployeeListProvider {
    var networkService: ListNetworkManager?

    init(networkService: ListNetworkManager) {
        self.networkService = networkService
    }

}
extension EmployeeListProvider: ProvidesEmployeeData {
    func fetchData(complition: @escaping (DTOModel?) -> Void) {
        networkService?.getEmployees { result in
            switch result {
            case .success(let employees):
                DispatchQueue.main.async {
                    complition(employees)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
