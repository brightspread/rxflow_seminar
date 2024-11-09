//
//  HomeDetailCoordinator.swift
//  Home
//
//  Created by Leo on 11/3/24.
//

import Foundation
import Coordinator

public protocol HomeDetailCoordinator: Coordinator {
    @MainActor
    func presentAlert(_ message: String)

    @MainActor
    func finish()
}
