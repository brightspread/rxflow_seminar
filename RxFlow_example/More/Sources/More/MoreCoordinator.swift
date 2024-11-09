//
//  MoreCoordinator.swift
//  More
//
//  Created by Leo on 11/3/24.
//

import Coordinator

public protocol MoreCoordinator: Coordinator {
    
    @MainActor
    func presentAlert(_ message: String)
    
    @MainActor
    func finish()
    
}
