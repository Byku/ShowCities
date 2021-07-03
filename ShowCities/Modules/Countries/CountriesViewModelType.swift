//
//  CountriesViewModelType.swift
//  ShowCities
//
//  Created by Дмитрий Иванов on 03.07.2021.
//

import Combine

struct CountriesViewModelInput { }

enum CountriesState {
    case idle
}

extension CountriesState: Equatable {
    static func == (lhs: CountriesState, rhs: CountriesState) -> Bool {
        switch (lhs, rhs) {
        case (.idle, .idle): return true
        }
    }
}

typealias CountriesViewModelOutput = AnyPublisher<CountriesState, Never>

protocol CountriesViewModelType {
    var doneSignal: PassthroughSubject<Void, Never> { set get }
    func transform(input: CountriesViewModelInput) -> CountriesViewModelOutput
}
