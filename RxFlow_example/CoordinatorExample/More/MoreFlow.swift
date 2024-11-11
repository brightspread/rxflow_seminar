//
//  MoreFlow.swift
//  CoordinatorExample
//
//  Created by Leo on 11/11/24.
//

import UIKit
import RxSwift
import RxCocoa
import RxFlow
import FlowStep
import More

final class MoreFlow: Flow {
    var root: any Presentable {
        moreVC
    }
    
    private let moreVC: MoreViewController
    private let moreVM: MoreViewModel
    
    init() {
        self.moreVM = MoreViewModel()
        self.moreVC = MoreViewController(viewModel: moreVM)
    }
    
    func navigate(to step: any Step) -> FlowContributors {
        guard let step = step as? MoreStep else {
            return .one(flowContributor: .forwardToParentFlow(withStep: step))
        }
        
        switch step {
        case .moreIsRequired:
            return navigateToMore()
        case .moreIsCompleted:
            return .end(forwardToParentFlowWithStep: HomeStep.moreIsCompleted)
        }

    }
    
    private func navigateToMore() -> FlowContributors {
        return .one(flowContributor: .contribute(
            withNextPresentable: moreVC, withNextStepper: moreVM
        ))

    }
}

