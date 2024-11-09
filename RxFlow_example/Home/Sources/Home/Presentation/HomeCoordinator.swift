//
//  HomeCoordinator.swift
//  Home
//
//  Created by Leo on 11/2/24.
//
import Coordinator

public protocol HomeCoordinator : Coordinator {
    
    @MainActor
    func presentAlert(_ message: String)
    
    @MainActor
    func showDetail()
    
    @MainActor
    func showMore()
}
