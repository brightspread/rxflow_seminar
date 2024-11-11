//
//  RootFlow.swift
//  CoordinatorExample
//
//  Created by Leo on 11/9/24.
//

import UIKit
import RxSwift
import RxFlow
import FlowStep

final class RootFlow: Flow {
    var root: Presentable {
        return self.rootViewController
    }
    
    private let rootViewController = UINavigationController()
    
    func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? RootStep else { return .none }
        
        switch step {
        case .rootIsRequired:
            return navigateToHome()
        case .presentAlert(let message):
            return presentAlert(message)
        }
    }
    
    private func navigateToHome() -> FlowContributors {
        let homeFlow = HomeFlow(navigation: rootViewController)
        
        Flows.use(homeFlow, when: .created) { root in
            self.rootViewController.pushViewController(root, animated: true)
        }
        
        return .one(flowContributor: .contribute(
            withNextPresentable: homeFlow,
            withNextStepper: OneStepper(withSingleStep: HomeStep.homeIsRequired)
        ))
    }
    
    private func presentAlert(_ message: String) -> FlowContributors {
        let alert = UIAlertController(title: "RootCoordinator의 Alert", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default)
        alert.addAction(action)
        rootViewController.present(alert, animated: true)
        return .none
    }

}
