import UIKit

public protocol Coordinator: AnyObject {
    var navigation: UINavigationController { get set }
    var parentCoordinator: Coordinator? { get set }
    var childCoordinators: [Coordinator] { get set }
    
    func childDidFinish(_ child: Coordinator?)
}

public extension Coordinator {
    func childDidFinish(_ child: (Coordinator)?) {
        guard let child = child else { return }
        if let index = childCoordinators.firstIndex(where: { $0 === child }) {
            childCoordinators.remove(at: index)
            print("\(child) has finished on \(self)")
        }
    }
}
