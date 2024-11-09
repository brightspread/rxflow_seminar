//
//  MoreCoordinatorImpl.swift
//  CoordinatorExample
//
//  Created by Leo on 11/3/24.
//

import UIKit
import Coordinator
import More
import Home

final class MoreCoordinatorImpl: MoreCoordinator {
    
    var navigation: UINavigationController
    var parentCoordinator: (any Coordinator)?
    var childCoordinators: [any Coordinator]
    
    init(
        navigation: UINavigationController,
        parentCoordinator: (any Coordinator)? = nil,
        childCoordinators: [any Coordinator] = []
    ) {
        print("[init] MoreCoordinatorImpl")
        self.navigation = navigation
        self.parentCoordinator = parentCoordinator
        self.childCoordinators = childCoordinators
    }
    
    deinit {
        print("[deinit] MoreCoordinatorImpl")
    }
    
    func start() -> UIViewController {
        let vm = MoreViewModel(coordinator: self)
        let vc = MoreViewController(viewModel: vm)
        return vc
    }
    
    func presentAlert(_ message: String) {
        if let parentCoordinator = parentCoordinator as? HomeCoordinator {
            parentCoordinator.presentAlert(message)
        }
    }
    
    func finish() {
        childCoordinators.removeAll()
        if let parentCoordinator {
            parentCoordinator.childDidFinish(self)
        }
    }
}

