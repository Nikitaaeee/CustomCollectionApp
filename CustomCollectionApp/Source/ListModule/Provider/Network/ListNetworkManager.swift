//
//  ListNetworkManager.swift
//  CustomCollectionApp
//
//  Created by Nikita Kirshin on 13.11.2022.
//

import Foundation

struct ListNetworkManager {
    
    // MARK: - Properites

    private let networkService = NetworkService<ListEndPoint>()

    func getEmployees(completion: @escaping (Result<DTOModel, Error>) -> ()) {
        networkService.sendRequest(.employeesList, type: DTOModel.self) { result in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

// MARK: - Constants

private enum Constants {
    enum RequestErrors {
        static let requestError: String = "Please check your network connection"
    }
}
