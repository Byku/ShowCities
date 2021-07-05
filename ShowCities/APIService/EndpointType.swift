//
//  EndpointType.swift
//  ShowCities
//
//  Created by Дмитрий Иванов on 05.07.2021.
//

import Foundation

public protocol EndpointType {
    var baseURL: URL { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var task: HTTPTask { get }
    var headers: HTTPHeaders? { get }
}
