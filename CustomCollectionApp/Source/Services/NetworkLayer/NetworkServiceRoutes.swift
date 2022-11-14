//
//  NetworkServiceRoutes.swift
//  CustomCollectionApp
//
//  Created by Nikita Kirshin on 13.11.2022.
//

import Foundation

public typealias RequestResult<Type> = ((Result<Type, NetworkError>) -> Void)

protocol NetworkServiceRoutes: AnyObject {
    associatedtype EndPoint: EndPointType

    func sendRequest<T: Decodable>(_ route: EndPoint, type: T.Type, complition: @escaping RequestResult<T>)
}
