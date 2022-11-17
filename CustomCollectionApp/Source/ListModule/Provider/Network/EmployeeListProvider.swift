//
//  ListProvider.swift
//  CustomCollectionApp
//
//  Created by Nikita Kirshin on 13.11.2022.
//

import Foundation

protocol ProvidesEmployeeData: AnyObject {
    func fetchData(completion: @escaping ([Employee]?) -> Void)
    func refreshData(completion: @escaping  ([Employee]?) -> Void)
}

final class EmployeeListProvider {
    
    // MARK: - Properites

    @UserDefault(key: Constants.userDefaultsEmployeeKey, defaultValue: Date())
    private(set) var date: Date
    
    var networkManager: ListNetworkManager?
    var employeStorage: EmployeeStorageMainFunctional
    
    // MARK: - Lifecycle

    init(networkManager: ListNetworkManager,
         employeStorage: EmployeeStorageMainFunctional) {
        self.networkManager = networkManager
        self.employeStorage = employeStorage
    }
}

// MARK: - ProvidesEmployeeData

extension EmployeeListProvider: ProvidesEmployeeData {
    func fetchData(completion: @escaping ([Employee]?) -> Void) {
        if employeStorage.isEmpty {
            fetchDataFromNetworkService(completion: completion)
        } else {
            isOutdated()
            ? fetchIfOutdated(completion: completion)
            : completion(employeStorage.getAllItems())
        }
    }
    
    func refreshData(completion: @escaping  ([Employee]?) -> Void) {
        fetchDataFromNetworkService(completion: completion)
    }
}

// MARK: - Private

private extension EmployeeListProvider {
    func isOutdated() -> Bool {
        return Date() - date > Constants.maximumCacheInterval
        ? true
        : false
    }
    
    func fetchDataFromNetworkService(completion: @escaping ([Employee]?) -> Void) {
        networkManager?.getEmployees { result in
            switch result {
            case .success(let employees):
                DispatchQueue.main.async {
                    completion(employees.company.employees)
                    self.employeStorage.deleteAllItems()
                    self.employeStorage.save(items: employees.company.employees)
                    self.date = Date()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func fetchIfOutdated(completion: @escaping ([Employee]?) -> Void) {
        employeStorage.deleteAllItems()
        fetchDataFromNetworkService(completion: completion)
    }
}

// MARK: - Constants

private extension EmployeeListProvider {
    enum Constants {
        static let userDefaultsEmployeeKey: String = "timeAdded"
        static let maximumCacheInterval: Double = 3600
    }
}
