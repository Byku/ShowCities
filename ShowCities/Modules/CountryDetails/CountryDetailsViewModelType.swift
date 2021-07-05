//
//  CountryDetailsViewModelType.swift
//  ShowCities
//
//  Created by Дмитрий Иванов on 03.07.2021.
//

import Combine

struct CountryDetailsViewModelInput { }

enum CountryDetailsState {
    case idle
}

extension CountryDetailsState: Equatable {
    static func == (lhs: CountryDetailsState, rhs: CountryDetailsState) -> Bool {
        switch (lhs, rhs) {
        case (.idle, .idle): return true
        }
    }
}

typealias CountryDetailsViewModelOutput = AnyPublisher<CountryDetailsState, Never>

protocol CountryDetailsViewModelType {
    var doneSignal: PassthroughSubject<Void, Never> { set get }
    func transform(input: CountryDetailsViewModelInput) -> CountryDetailsViewModelOutput
}

