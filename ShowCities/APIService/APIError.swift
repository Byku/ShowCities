//
//  APIError.swift
//  ShowCities
//
//  Created by Дмитрий Иванов on 05.07.2021.
//

import Foundation

public enum APIErrors: Error {
    case urlError(URLError)
    case responseError(Int)
    case decodingError(DecodingError)
    case genericError
}
