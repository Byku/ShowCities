//
//  CountriesCoordinator.swift
//  ShowCities
//
//  Created by Дмитрий Иванов on 03.07.2021.
//

import Combine
import Foundation


class CountriesCoordinator: CoordinatorProtocol {
    var subscriptions = Set<AnyCancellable>()

    func start(from viewController: ObservedViewController) {
       
        let networkService = NetworkManager()
        let countriesViewModel = CountriesViewModel(networkService: networkService)
        let newViewController = CountriesViewController(viewModel: countriesViewModel)
        
        newViewController.view.frame = viewController.view.frame
        newViewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        viewController.addChild(newViewController)
        viewController.view.addSubview(newViewController.view)
        newViewController.didMove(toParent: viewController)
        
        let countryDetailsCoordinator = CountryDetailsCoordinator()
        countriesViewModel.doneSignal
            .subscribe(on: RunLoop.main)
            .sink(receiveValue: { countryViewModel in
                countryDetailsCoordinator.countryViewModel = countryViewModel
                self.coordinate(to: countryDetailsCoordinator, from: newViewController)
            })
            .store(in: &subscriptions)
    }
}
