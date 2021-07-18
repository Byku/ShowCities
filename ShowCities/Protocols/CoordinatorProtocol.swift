import Combine
import UIKit
 
protocol CoordinatorProtocol {
    func start(from viewController: ObservedViewController)
    func coordinate(to coordinator: CoordinatorProtocol, from viewController: ObservedViewController)
}

extension CoordinatorProtocol {
    func coordinate(to coordinator: CoordinatorProtocol, from viewController: ObservedViewController) {
        return coordinator.start(from: viewController)
    }
}
