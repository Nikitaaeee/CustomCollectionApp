//
//  ListEndPoint.swift
//  CustomCollectionApp
//
//  Created by Nikita Kirshin on 13.11.2022.
//

import Foundation

public enum ListEndPoint {
    case employeesList
}

    // MARK: - EndPointType

extension ListEndPoint: EndPointType {
    static let version = "/v3"

    var path: String {
        switch self {
        case .employeesList:
            return ListEndPoint.version + "/1d1cb4ec-73db-4762-8c4b-0b8aa3cecd4c"
        }
    }

    var httpMethod: HTTPMethod {
        .get
    }

    var task: HTTPTask {
        switch self {
        case .employeesList:
            return .request
        }
    }

    var headers: HTTPHeaders? {
        return nil
    }
}
