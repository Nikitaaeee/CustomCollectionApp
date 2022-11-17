//
//  NetworkServiceRoutes.swift
//  CustomCollectionApp
//
//  Created by Nikita Kirshin on 13.11.2022.
//

import Foundation

public typealias RequestResultCompletion<T> = ((Result<T, NetworkError>) -> Void)

protocol NetworkServiceRoutes: AnyObject {
    associatedtype EndPoint: EndPointType

    func sendRequest<T: Decodable>(_ route: EndPoint, type: T.Type, completion: @escaping RequestResultCompletion<T>)
}
