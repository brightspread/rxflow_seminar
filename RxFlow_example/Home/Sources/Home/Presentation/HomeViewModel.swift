//
//  HomeViewModel.swift
//  Home
//
//  Created by Leo on 11/2/24.
//

import Foundation
import RxFlow
import RxCocoa
import FlowStep

enum HomeViewAction {
    case detailTapped
    case moreTapped
    case alertTapped
}
/*
public final class HomeViewModel {
    
    weak var coordinator: HomeCoordinator?
    
    public init(coordinator: HomeCoordinator? = nil) {
        self.coordinator = coordinator
    }
    
    @MainActor
    func send(_ action: HomeViewAction) async {
        switch action {
        case .detailTapped:
            await coordinator?.showDetail()
        case .moreTapped:
            await coordinator?.showMore()
        case .alertTapped:
            await coordinator?.presentAlert("from Home")
        }
    }
    
}
 */
public final class HomeViewModel: Stepper {
    
    public let steps = PublishRelay<Step>()
    
    public init() {}
    
    @MainActor
    func send(_ action: HomeViewAction) async {
        switch action {
        case .detailTapped:
            steps.accept(HomeStep.homeDetailIsRequired)
        case .moreTapped:
            steps.accept(HomeStep.moreIsRequired)
        case .alertTapped:
            steps.accept(RootStep.presentAlert("from Home"))
        }
    }
    
}
