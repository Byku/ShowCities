//
//  CountriesViewModel.swift
//  ShowCities
//
//  Created by Дмитрий Иванов on 03.07.2021.
//

import Foundation
import Combine

class CountriesViewModel {
    public var doneSignal = PassthroughSubject<Void, Never>()
    private var subscribtions = Set<AnyCancellable>()
}

extension CountriesViewModel: CountriesViewModelType {
    func transform(input: CountriesViewModelInput) -> CountriesViewModelOutput {
        Just(CountriesState.idle).eraseToAnyPublisher()
    }
}
