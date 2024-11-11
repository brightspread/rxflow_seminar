//
//  HomeFlow.swift
//  CoordinatorExample
//
//  Created by Leo on 11/9/24.
//
import UIKit
import RxSwift
import RxFlow
import FlowStep
import Home

final class HomeFlow: Flow {
    var root: any Presentable {
        homeVC
    }
    
    private let navigation: UINavigationController
    private let homeVC: HomeViewController
    private let homeVM: HomeViewModel
    
    init(navigation: UINavigationController) {
        self.navigation = navigation
        self.homeVM = HomeViewModel()
        self.homeVC = HomeViewController(viewModel: homeVM)
    }
    
    func navigate(to step: any Step) -> FlowContributors {
        guard let step = step as? HomeStep else {
            return .one(flowContributor: .forwardToParentFlow(withStep: step))
        }
        
        switch step {
        case .homeIsRequired:
            return navigateToHome()
        case .homeDetailIsRequired:
            return navigateToHomeDetail()
        case .moreIsRequired:
            return navigateToMore()
        case .homeIsCompleted:
            return .none
        case .homeDetailIsCompleted:
            return .none
        case .moreIsCompleted:
            return .none
        }
    }
    
    private func navigateToHome() -> FlowContributors {
        return .one(flowContributor: .contribute(
            withNextPresentable: homeVC, withNextStepper: homeVM
        ))
    }
    
    private func navigateToHomeDetail() -> FlowContributors {
        let homeDetailFlow = HomeDetailFlow()

        Flows.use(homeDetailFlow, when: .created) { root in
            self.navigation.pushViewController(root, animated: true)
        }
        
        return .one(flowContributor:
                .contribute(
                    withNextPresentable: homeDetailFlow,
                    withNextStepper: OneStepper(withSingleStep: HomeDetailStep.homeDetailIsRequired)
                )
        )
    }
    
    private func navigateToMore() -> FlowContributors {
        let moreFlow = MoreFlow()

        Flows.use(moreFlow, when: .created) { root in
            self.navigation.pushViewController(root, animated: true)
        }
        
        return .one(flowContributor:
                .contribute(
                    withNextPresentable: moreFlow,
                    withNextStepper: OneStepper(withSingleStep: MoreStep.moreIsRequired)
                )
        )
    }

}
