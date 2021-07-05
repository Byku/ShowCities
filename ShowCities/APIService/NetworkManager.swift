//
//  NetworkManager.swift
//  ShowCities
//
//  Created by Дмитрий Иванов on 05.07.2021.
//

import Foundation
import Combine

protocol NetworkManagerable {
    func all() -> Future<Result<[CountryEntity], APIErrors>, Never>
    func countryName(name: String) -> Future<Result<CountryEntity, APIErrors>, Never>
}

public class NetworkManager {
    typealias Endpoint = CountiesAPI
    private var router: Router<Endpoint>
    private var subscriptions: Set<AnyCancellable>
    
    public init() {
        self.router = Router<Endpoint>()
        self.subscriptions = Set<AnyCancellable>()
    }
}

extension NetworkManager: NetworkManagerable {
    func all() -> Future<Result<[CountryEntity], APIErrors>, Never> {
        return Future<Result<[CountryEntity], APIErrors>, Never> { [unowned self] promise in
            self.router.request(.all)
                .receive(on: RunLoop.main)
                .sink(receiveCompletion: { completion in
                    if case let .failure(error) = completion {
                        switch error {
                        case let urlError as URLError:
                            promise(.success(.failure(.urlError(urlError))))
                        case let decodingError as DecodingError:
                            promise(.success(.failure(.decodingError(decodingError))))
                        case let apiError as APIErrors:
                            promise(.success(.failure(apiError)))
                        default:
                            promise(.success(.failure(.genericError)))
                        }
                    }
                }, receiveValue: {
                    promise(.success(.success($0)))
                })
                .store(in: &subscriptions)
        }
    }
    
    func countryName(name: String) -> Future<Result<CountryEntity, APIErrors>, Never> {
        return Future<Result<CountryEntity, APIErrors>, Never> { [unowned self] promise in
            self.router.request(.name(name: name))
                .receive(on: RunLoop.main)
                .sink(receiveCompletion: { completion in
                    if case let .failure(error) = completion {
                        switch error {
                        case let urlError as URLError:
                            promise(.success(.failure(.urlError(urlError))))
                        case let decodingError as DecodingError:
                            promise(.success(.failure(.decodingError(decodingError))))
                        case let apiError as APIErrors:
                            promise(.success(.failure(apiError)))
                        default:
                            promise(.success(.failure(.genericError)))
                        }
                    }
                }, receiveValue: {
                    promise(.success(.success($0)))
                })
                .store(in: &subscriptions)
        }
    }
}
