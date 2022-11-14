//
//  ListNetworkManager.swift
//  CustomCollectionApp
//
//  Created by Nikita Kirshin on 13.11.2022.
//

import Foundation

struct ListNetworkManager {
    private let router = NetworkService<ListEndPoint>()

    func getEmployees(completion: @escaping (Result<DTOModel, Error>) -> ()) {
        router.sendRequest(.employeesList, type: DTOModel.self) { result in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

private enum Constants {
    enum RequestErrors {
        static let requestError: String = "Please check your network connection"
    }
}

private extension ListNetworkManager {
    func handleNetworkResponse(_ response: HTTPURLResponse) -> Result<String, NetworkResponse> {
        switch response.statusCode {
        case 200...299: return .success(NetworkResponse.ok.rawValue)
        case 401...500: return .failure(NetworkResponse.authenticationError)
        case 501...599: return .failure(NetworkResponse.badRequest)
        case 600: return .failure(NetworkResponse.outdated)
        default: return .failure(NetworkResponse.failed)
        }
    }
}
