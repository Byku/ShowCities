//
//  AppCoordinator.swift
//  ShowCities
//
//  Created by Дмитрий Иванов on 03.07.2021.
//

import Foundation
import Combine
 
class AppCoordinator: CoordinatorProtocol {
    lazy var countriesCoordinator = CountriesCoordinator()
    private var subscriptions = Set<AnyCancellable>()
    
    @discardableResult
    func start(from viewController: ObservedViewController) -> AnyPublisher<Void, Never> {
        let vc = viewController
        vc.lifecycleEvent
            .receive(on: RunLoop.main)
            .filter { $0 == .viewDidAppear }
            .sink { _ in
                self.coordinate(to: self.countriesCoordinator, from: viewController)
            }
            .store(in: &subscriptions)
        
        return Empty().eraseToAnyPublisher()
    }
}

