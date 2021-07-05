//
//  CountryDetailsCoordinator.swift
//  ShowCities
//
//  Created by Дмитрий Иванов on 03.07.2021.
//

import Combine

class CountryDetailsCoordinator: CoordinatorProtocol {
    var subscriptions = Set<AnyCancellable>()

    func start(from viewController: ObservedViewController) -> AnyPublisher<Void, Never> {
        let countryDetailsViewModel = CountryDetailsViewModel()
        let newViewController = CountryDetailsViewController(viewModel: countryDetailsViewModel)
        
        viewController.present(newViewController, animated: true)

        return Empty().eraseToAnyPublisher()
    }
}
