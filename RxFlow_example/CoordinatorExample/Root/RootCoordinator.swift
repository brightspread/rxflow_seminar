//
//  RootCoordinator.swift
//  CoordinatorExample
//
//  Created by Leo on 11/2/24.
//
import UIKit
import Coordinator
import Home

final class RootCoordinator: Coordinator {

    var navigation: UINavigationController
    var parentCoordinator: (any Coordinator)?
    var childCoordinators: [Coordinator] = []
    
    init(navigation: UINavigationController = UINavigationController()) {
        print("[init] RootCoordinator")
        self.navigation = navigation
    }
    
    deinit {
        print("[deinit] \(self)")
    }
    
    func start() {
        let homeCoordinator = HomeCoordinatorImpl(navigation: navigation, parentCoordinator: self)
        let homeVC = homeCoordinator.start()

        navigation.pushViewController(homeVC, animated: true)
        childCoordinators.append(homeCoordinator)
    }
    
    func presentAlert(_ message: String) {
        let alert = UIAlertController(title: "RootCoordinator의 Alert", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default)
        alert.addAction(action)
        navigation.present(alert, animated: true)
    }
}
