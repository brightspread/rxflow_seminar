//
//  RootStep.swift
//  FlowStep
//
//  Created by Leo on 11/9/24.
//

import RxFlow

public enum RootStep: Step {
    case rootIsRequired
    case presentAlert(String)
}
