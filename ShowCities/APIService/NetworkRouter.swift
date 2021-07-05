//
//  NetworkRouter.swift
//  ShowCities
//
//  Created by Дмитрий Иванов on 05.07.2021.
//

import Foundation
import Combine

public protocol NetworkRouter: class {
    associatedtype Endpoint = EndpointType
    func request<T: Decodable>(_ route: Endpoint) -> AnyPublisher<T, Error>
    func cancel()
}
