//
//  NetworkService.swift
//  CustomCollectionApp
//
//  Created by Nikita Kirshin on 13.11.2022.
//

import Foundation

final class NetworkService<EndPoint: EndPointType>: NetworkServiceRoutes {
    private var task: URLSessionTask?

    func sendRequest<T: Decodable>(_ route: EndPoint, type: T.Type, complition: @escaping RequestResult<T>) {
        let session = URLSession.shared

        do {
            guard let request = try self.buildRequest(from: route) else { return }
            task = session.dataTask(with: request, completionHandler: { data, response, error in
                guard let data = data, error == nil else {
                    complition(.failure(NetworkError.connectionFailed))
                    return
                }
        
                guard let response = response as? HTTPURLResponse else { return }
                switch response.statusCode {
                case 200..<299:
                    complition(.failure(.successfulConnection))
                case 300..<399:
                    complition(.failure(NetworkError.redirection))
                case 400..<499:
                    complition(.failure(NetworkError.clientError))
                case 500..<599:
                    complition(.failure(NetworkError.serverError))
                default:
                    complition(.failure(NetworkError.connectionFailed))
                }
                
                guard let data = self.jsonDecode(type: type.self, from: data) else { return }
                complition(.success(data))
            })
        } catch {
            print(error.localizedDescription)
            complition(.failure(error as! NetworkError))
            
        }
        
        DispatchQueue.main.async {
            self.task?.resume()
        }
    }
}

private extension NetworkService {
    func buildRequest(from route: EndPoint) throws -> URLRequest? {
        guard let url = configureURL(route: route) else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = route.httpMethod.rawValue
        
        do {
            switch route.task {
            case .request:
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            case .requestParameters(
                let bodyParameters,
                let urlParameters
            ):
                try self.configureParameters(bodyParameters: bodyParameters, urlParameters: urlParameters, request: &request)
            case .requestParametersAndHeaders(let bodyParameters, let urlParameters, let additionHeaders):
                self.addAdditionalHeaders(additionHeaders, request: &request)
                try self.configureParameters(bodyParameters: bodyParameters, urlParameters: urlParameters, request: &request)
            }
            return request
        } catch {
            throw error
        }
    }
    
    func configureURL(route: EndPoint) -> URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = EndPointAPI.scheme
        urlComponents.host = EndPointAPI.hostURL
        urlComponents.path = route.path

        return urlComponents.url
    }
    
    func configureParameters(bodyParameters: Parameters?, urlParameters: Parameters?, request: inout URLRequest) throws {
        
        do {
            if let bodyParameters = bodyParameters {
                try JSONParameterEncoder.encode(urlRequest: &request, with: bodyParameters)
            }
            if let urlParameters = urlParameters {
                try URLParameterEncoder.encode(urlRequest: &request, with: urlParameters)
            }
        } catch {
            throw error
        }
    }
    
    func addAdditionalHeaders(_ additionalHeaders: HTTPHeaders?, request: inout URLRequest) {
        guard let headers = additionalHeaders else { return }
        for (key, value) in headers {
            request.setValue(value, forHTTPHeaderField: key)
        }
    }
    
    func jsonDecode<T: Decodable>(type: T.Type, from data: Data?) -> T? {
        let decoder = JSONDecoder()
        guard
            let data = data,
            let response = try? decoder.decode(type.self, from: data) else { return nil }
        
        return response
    }
}
