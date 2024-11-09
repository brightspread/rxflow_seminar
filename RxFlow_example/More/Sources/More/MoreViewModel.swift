//
//  MoreViewModel.swift
//  More
//
//  Created by Leo on 11/3/24.
//

import Foundation

enum MoreViewAction {
    case dismiss
    case alertTapped
}

public final class MoreViewModel {
    weak var coordinator: MoreCoordinator?
    
    public init(coordinator: MoreCoordinator? = nil) {
        self.coordinator = coordinator
    }
    
    @MainActor
    func send(_ action: MoreViewAction) {
        switch action {
        case .dismiss:
            coordinator?.finish()
        case .alertTapped:
            coordinator?.presentAlert("from More")
        }
    }
}
