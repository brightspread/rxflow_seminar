//
//  HomeDetailViewModel.swift
//  Home
//
//  Created by Leo on 11/3/24.
//

import Foundation
import RxSwift
import RxCocoa
import RxFlow
import FlowStep

enum HomeDetailViewAction {
    case dismiss
    case alertTapped
}

public final class HomeDetailViewModel: Stepper {
    public let steps = PublishRelay<Step>()
    
    
    weak var coordinator: (HomeDetailCoordinator)?

    public init(coordinator: HomeDetailCoordinator? = nil) {
        self.coordinator = coordinator
    }
    
    @MainActor
    func send(action: HomeDetailViewAction) {
        switch action {
        case .dismiss:
//            coordinator?.finish()
            steps.accept(HomeDetailStep.homeDetailIsCompleted)
        case .alertTapped:
//            coordinator?.presentAlert("from HomeDetail")
            steps.accept(RootStep.presentAlert("from HomeDetai"))
        }
    }
    
}
