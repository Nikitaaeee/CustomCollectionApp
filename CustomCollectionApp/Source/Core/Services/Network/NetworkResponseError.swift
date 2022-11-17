//
//  NetworkResponse.swift
//  CustomCollectionApp
//
//  Created by Nikita Kirshin on 13.11.2022.
//

import Foundation

enum NetworkResponse: String, Error {
    case ok = "Everything OK"
    case authenticationError = "Authentification Needed"
    case badRequest = "Bad Request"
    case outdated = "Outdated URL"
    case failed = "Network request failed"
    case noData = "No data to decode from response"
    case unableToDecode = "Decoding Failed"
}
