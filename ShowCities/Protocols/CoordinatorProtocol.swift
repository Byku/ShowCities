import Combine
import UIKit
 
protocol CoordinatorProtocol {
    func start(from viewController: ObservedViewController) -> AnyPublisher<Void, Never>
    func coordinate(to coordinator: CoordinatorProtocol, from viewController: ObservedViewController) -> AnyPublisher<Void, Never>
}

extension CoordinatorProtocol {
    @discardableResult
    func coordinate(to coordinator: CoordinatorProtocol, from viewController: ObservedViewController) -> AnyPublisher<Void, Never> {
        return coordinator.start(from: viewController)
    }
}
