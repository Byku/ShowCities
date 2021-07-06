//
//  CountriesViewModel.swift
//  ShowCities
//
//  Created by Дмитрий Иванов on 03.07.2021.
//

import Foundation
import Combine

class CountriesViewModel {
    public let isLoadingAction = PassthroughSubject<Void, Never>()
    public let startLoadingAction = PassthroughSubject<Void, Never>()
    public var doneSignal = PassthroughSubject<Void, Never>()
    private var subscribtions = Set<AnyCancellable>()
    internal let networkService: NetworkManagerable
    internal var countriesArray: Array<CountryEntity>
    
    init(networkService: NetworkManagerable) {
        self.networkService = networkService
        self.countriesArray = []
    }
}

extension CountriesViewModel: CountriesViewModelType {
    func transform(input: CountriesViewModelInput) -> CountriesViewModelOutput {
         input.lifeCycleEvent
            .filter { $0 == .viewDidAppear }
            .sink { _ in
                self.startLoadingAction.send()
            }
            .store(in: &subscribtions)
        
        let refreshInput = input.refreshEvent
            .receive(on: RunLoop.main)
            .debounce(for: .milliseconds(500), scheduler: RunLoop.main)
            .eraseToAnyPublisher()
            
        let retryButtonInput = input.retryTapEvent
            .receive(on: RunLoop.main)
            .debounce(for: .milliseconds(500), scheduler: RunLoop.main)
            .eraseToAnyPublisher()
        
        let loadingAction = retryButtonInput
            .merge(with: refreshInput, startLoadingAction)
            .flatMap { [unowned self] _ -> AnyPublisher<CountriesState, Never> in
                self.isLoadingAction.send()
                return self.loadCountries()
            }
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
        
        let isLoadind = isLoadingAction
            .map { CountriesState.loading }
            .eraseToAnyPublisher()
        
        return isLoadind
            .merge(with: loadingAction)
            .removeDuplicates()
            .eraseToAnyPublisher()
    }
            
    func numberOfRows() -> Int {
        self.countriesArray.count
    }
    
    func cellViewModel(for row: Int) -> CountryViewModelProtocol {
        let viewModel = countriesArray[row]
        let countyViewModel = CountryViewModel(countryName: viewModel.name, capitalCityName: viewModel.capital)
        return countyViewModel
    }
}

private extension CountriesViewModel {
    func loadCountries() -> AnyPublisher<CountriesState, Never> {
        self.networkService.all()
            .map { result -> CountriesState in
                switch result {
                case let .success(entity):
                    self.countriesArray = entity
                    return .ready
                case let .failure(error):
                    print(error)
                    return .failure(error)
                }
        }
        .eraseToAnyPublisher()
    }
}
