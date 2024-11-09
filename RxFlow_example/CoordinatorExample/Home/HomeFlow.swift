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
    
    private let homeVC: HomeViewController
    private let homeVM: HomeViewModel
    
    init() {
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
            return .none
        case .moreIsRequired:
            return .none
        case .homeIsCompleted:
            return .none
        }
    }
    
    private func navigateToHome() -> FlowContributors {
        return .one(flowContributor: .contribute(
            withNextPresentable: homeVC, withNextStepper: homeVM
        ))
    }
    
    
}
