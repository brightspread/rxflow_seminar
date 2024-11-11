//
//  MoreViewModel.swift
//  More
//
//  Created by Leo on 11/3/24.
//

import Foundation
import RxSwift
import RxCocoa
import RxFlow
import FlowStep

enum MoreViewAction {
    case dismiss
    case alertTapped
}

public final class MoreViewModel: Stepper {
    public let steps = RxRelay.PublishRelay<any RxFlow.Step>()
    
    weak var coordinator: MoreCoordinator?
    
    public init(coordinator: MoreCoordinator? = nil) {
        self.coordinator = coordinator
    }
    
    @MainActor
    func send(_ action: MoreViewAction) {
        switch action {
        case .dismiss:
//            coordinator?.finish()
            steps.accept(MoreStep.moreIsCompleted)
        case .alertTapped:
//            coordinator?.presentAlert("from More")
            steps.accept(RootStep.presentAlert("from More"))
        }
    }
}
