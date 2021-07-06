//
//  CountriesViewModelType.swift
//  ShowCities
//
//  Created by Дмитрий Иванов on 03.07.2021.
//

import Combine

struct CountriesViewModelInput {
    let lifeCycleEvent: AnyPublisher<LifecycleEvent, Never>
    let retryTapEvent: AnyPublisher<Void, Never>
    let refreshEvent: AnyPublisher<Void, Never>
}

enum CountriesState {
    case loading
    case ready
    case failure(Error)
}

extension CountriesState: Equatable {
    static func == (lhs: CountriesState, rhs: CountriesState) -> Bool {
        switch (lhs, rhs) {
        case (.loading, .loading): return true
        case (.ready, .ready): return true
        case (.failure, .failure): return true
        default: return false
        }
    }
}

typealias CountriesViewModelOutput = AnyPublisher<CountriesState, Never>

protocol CountriesViewModelType {
    var doneSignal: PassthroughSubject<CountryViewModelProtocol, Never> { set get }
    var networkService: NetworkManagerable { get }
    var countriesArray: Array<CountryEntity> { set get}
    func numberOfRows() -> Int
    func transform(input: CountriesViewModelInput) -> CountriesViewModelOutput
    func cellViewModel(for row: Int) -> CountryViewModelProtocol
}
