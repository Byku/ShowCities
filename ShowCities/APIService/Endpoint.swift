//
//  Endpoint.swift
//  ShowCities
//
//  Created by Дмитрий Иванов on 05.07.2021.
//

import Foundation

public enum CountiesAPI {
    case all
    case name(name: String)
}

extension CountiesAPI: EndpointType {
    public var baseURL: URL {
        let urlString = "https://restcountries.eu/"
        guard let url = URL(string: urlString) else {
            fatalError("baseURL could not be configured.")
        }
        return url
    }
    
    public var path: String {
        switch self {
        case .all:
            return "rest/v2/all"
        case let .name(name):
            return "rest/v2/name/\(name)"
        }
    }
    
    public var httpMethod: HTTPMethod {
        .get
    }
    
    public var task: HTTPTask {
        switch self {
        case .all:
            return .request
        case .name(_):
            return .request
        }
    }
    
    public var headers: HTTPHeaders? {
        .none
    }
    
    
}
