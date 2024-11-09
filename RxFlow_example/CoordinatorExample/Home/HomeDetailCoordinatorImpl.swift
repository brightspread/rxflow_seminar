//
//  HomeDetailCoordinatorImpl.swift
//  CoordinatorExample
//
//  Created by Leo on 11/3/24.
//

import UIKit
import Coordinator
import Home

final class HomeDetailCoordinatorImpl: HomeDetailCoordinator {
    var navigation: UINavigationController
    var parentCoordinator: (any Coordinator)?
    var childCoordinators: [any Coordinator]
    
    init(
        navigation: UINavigationController,
        parentCoordinator: (any Coordinator)? = nil,
        childCoordinators: [any Coordinator] = []
    ) {
        print("[init] HomeDetailCoordinatorImpl")
        self.navigation = navigation
        self.parentCoordinator = parentCoordinator
        self.childCoordinators = childCoordinators
    }
    
    deinit {
        print("[deinit] HomeDetailCoordinatorImpl")
    }
    
    func start() -> UIViewController {
        let homeDetailVM = HomeDetailViewModel(coordinator: self)
        let homeDetailVC = HomeDetailViewController(viewModel: homeDetailVM)
        
        return homeDetailVC
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
