//
//  EndPointType.swift
//  CustomCollectionApp
//
//  Created by Nikita Kirshin on 13.11.2022.
//

import Foundation

protocol EndPointType {
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var task: HTTPTask { get }
    var headers: HTTPHeaders? { get }
    var scheme: String { get }
    var hostURL: String { get }
}

