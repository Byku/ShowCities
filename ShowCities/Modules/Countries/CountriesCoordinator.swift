//
//  CountriesCoordinator.swift
//  ShowCities
//
//  Created by Дмитрий Иванов on 03.07.2021.
//

import Combine


class CountriesCoordinator: CoordinatorProtocol {
    var subscriptions = Set<AnyCancellable>()

    func start(from viewController: ObservedViewController) -> AnyPublisher<Void, Never> {
       
        let countriesViewModel = CountriesViewModel()
        let newViewController = CountriesViewController(viewModel: countriesViewModel)
        
        newViewController.view.frame = viewController.view.frame
        newViewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        viewController.addChild(newViewController)
        viewController.view.addSubview(newViewController.view)
        newViewController.didMove(toParent: viewController)

        return Empty().eraseToAnyPublisher()
    }
}