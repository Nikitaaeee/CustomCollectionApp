//
//  ParameterEncoder.swift
//  CustomCollectionApp
//
//  Created by Nikita Kirshin on 13.11.2022.
//

import Foundation

public protocol ParameterEncoder {
    static func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws
}

public enum NetworkError: String, Error {
    case successfulConnection = "Successful connection"
    case connectionFailed = "No internet connection"
    case redirection = "Redirection"
    case encodingFailed = "Parameters encoding failed"
    case missingUrl = "URL is nil"
    case serverError = "Server errors"
    case clientError = "Client error with connection"
}

public typealias Parameters = [String: Any]

