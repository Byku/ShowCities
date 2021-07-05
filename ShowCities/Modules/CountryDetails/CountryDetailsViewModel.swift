//
//  CountryDetailsViewModel.swift
//  ShowCities
//
//  Created by Дмитрий Иванов on 03.07.2021.
//

import Foundation
import Combine

class CountryDetailsViewModel {
    public var doneSignal = PassthroughSubject<Void, Never>()
    private var subscribtions = Set<AnyCancellable>()
}

extension CountryDetailsViewModel: CountryDetailsViewModelType {
    func transform(input: CountryDetailsViewModelInput) -> CountryDetailsViewModelOutput {
        Just(CountryDetailsState.idle).eraseToAnyPublisher()
    }
}
