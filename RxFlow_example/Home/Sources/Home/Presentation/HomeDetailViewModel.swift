//
//  HomeDetailViewModel.swift
//  Home
//
//  Created by Leo on 11/3/24.
//

import Foundation

enum HomeDetailViewAction {
    case dismiss
    case alertTapped
}

public final class HomeDetailViewModel {
    
    weak var coordinator: (HomeDetailCoordinator)?

    public init(coordinator: HomeDetailCoordinator? = nil) {
        self.coordinator = coordinator
    }
    
    @MainActor
    func send(action: HomeDetailViewAction) {
        switch action {
        case .dismiss:
            coordinator?.finish()
        case .alertTapped:
            coordinator?.presentAlert("from HomeDetail")
        }
    }
    
}
