//
//  HomeCoordinatorImpl.swift
//  CoordinatorExample
//
//  Created by Leo on 11/2/24.
//

import UIKit
import Coordinator
import Home

final class HomeCoordinatorImpl: HomeCoordinator {
    
    var navigation: UINavigationController
    var parentCoordinator: (any Coordinator)?
    var childCoordinators: [any Coordinator]
    
    init(
        navigation: UINavigationController,
        parentCoordinator: (any Coordinator)? = nil,
        childCoordinators: [any Coordinator] = []
    ) {
        print("[init] HomeCoordinatorImpl")
        self.navigation = navigation
        self.parentCoordinator = parentCoordinator
        self.childCoordinators = childCoordinators
    }
    
    deinit {
        print("[deinit] HomeCoordinatorImpl")
    }
    
    func start() -> UIViewController {
        let homeVM = HomeViewModel(coordinator: self)
        let homeVC = HomeViewController(viewModel: homeVM)
        return homeVC
    }
    
    func showDetail() {
        let homeDetailCoordinator = HomeDetailCoordinatorImpl(navigation: navigation, parentCoordinator: self)
        let vc = homeDetailCoordinator.start()
        childCoordinators.append(homeDetailCoordinator)
        navigation.pushViewController(vc, animated: true)
    }
    
    func showMore() {
        let moreCoordinator = MoreCoordinatorImpl(navigation: navigation, parentCoordinator: self)
        let vc = moreCoordinator.start()
        childCoordinators.append(moreCoordinator)
        navigation.pushViewController(vc, animated: true)
    }
    
    func presentAlert(_ message: String) {
        if let parentCoordinator = parentCoordinator as? RootCoordinator {
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

