//
//  HomeViewModel.swift
//  Home
//
//  Created by Leo on 11/2/24.
//

import Foundation

enum HomeViewAction {
    case detailTapped
    case moreTapped
    case alertTapped
}

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
