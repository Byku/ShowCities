//
//  Router.swift
//  ShowCities
//
//  Created by Дмитрий Иванов on 05.07.2021.
//

import Foundation
import Combine

final public class Router<Endpoint: EndpointType>: NetworkRouter {
    private var task: URLSessionTask?
    private lazy var decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        return decoder
    }()
    
    public init() {}
    
    public func request<T: Decodable>(_ route: Endpoint) -> AnyPublisher<T, Error> {
        let request = self.buildRequest(from: route)
        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { [weak self] (data, response) -> Data in
                guard let self = self else {
                    fatalError("NetworkLayer Error")
                }
                return try self.validateResponseStatus(data: data, response: response as? HTTPURLResponse)
            }
            .decode(type: T.self, decoder: decoder)
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
    
    public func cancel() {
        self.task?.cancel()
    }
    
    fileprivate func validateResponseStatus(data: Data, response: HTTPURLResponse?) throws -> Data {
           guard let httpResponse = response,
               200...299 ~= httpResponse.statusCode else {
                   throw APIErrors.responseError(response?.statusCode ?? 500)
           }
           return data
       }
    
    fileprivate func buildRequest(from route: Endpoint) -> URLRequest {
        var request = URLRequest(url: route.baseURL.appendingPathComponent(route.path),
                                 cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
                                 timeoutInterval: 10.0)
        
        request.httpMethod = route.httpMethod.rawValue
        switch route.task {
        case .request:
            request.setValue("application/json", forHTTPHeaderField: "ContentType")
        }
        
        return request
    }
}
