//
//  CountryDetailsCoordinator.swift
//  ShowCities
//
//  Created by Дмитрий Иванов on 03.07.2021.
//

import Combine

class CountryDetailsCoordinator: CoordinatorProtocol {
    var countryViewModel: CountryViewModelProtocol?
    var subscriptions = Set<AnyCancellable>()

    func start(from viewController: ObservedViewController) {
        let countryDetailsViewModel = CountryDetailsViewModel()
        let newViewController = CountryDetailsViewController(viewModel: countryDetailsViewModel)
        
        viewController.present(newViewController, animated: true) {
            guard let viewModel = self.countryViewModel else { return }
            newViewController.showCapitalCityName(with: viewModel)
        }
    }
}
