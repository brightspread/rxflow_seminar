//
//  HomeDetailFlow.swift
//  CoordinatorExample
//
//  Created by Leo on 11/9/24.
//

import UIKit
import RxSwift
import RxCocoa
import RxFlow
import FlowStep
import Home

final class HomeDetailFlow: Flow {
    var root: any Presentable {
        homeDetailVC
    }
    
    private let homeDetailVC: HomeDetailViewController
    private let homeDetailVM: HomeDetailViewModel
    
    init() {
        self.homeDetailVM = HomeDetailViewModel()
        self.homeDetailVC = HomeDetailViewController(viewModel: homeDetailVM)
    }
    
    func navigate(to step: any Step) -> FlowContributors {
        guard let step = step as? HomeDetailStep else {
            return .one(flowContributor: .forwardToParentFlow(withStep: step))
        }
        
        switch step {
        case .homeDetailIsRequired:
            return navigateToHomeDetail()
        case .homeDetailIsCompleted:
            return .end(forwardToParentFlowWithStep: HomeStep.homeDetailIsCompleted)
        }

    }
    
    private func navigateToHomeDetail() -> FlowContributors {
        return .one(flowContributor: .contribute(
            withNextPresentable: homeDetailVC, withNextStepper: homeDetailVM
        ))
    }
}

