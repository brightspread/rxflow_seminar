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
            return .none
        }
    }
    
    private func navigateToHome() -> FlowContributors {
        let homeFlow = HomeFlow()
        
        Flows.use(homeFlow, when: .created) { root in
            self.rootViewController.pushViewController(root, animated: true)
        }
        
        return .one(flowContributor: .contribute(
            withNextPresentable: homeFlow,
            withNextStepper: OneStepper(withSingleStep: HomeStep.homeIsRequired)
        ))
    }
    
}
