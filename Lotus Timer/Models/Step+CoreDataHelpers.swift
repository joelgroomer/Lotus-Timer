//
//  Step+CoreDataHelpers.swift
//  Lotus Timer
//
//  Created by Joel Groomer on 11/21/20.
//  Copyright © 2020 Julltron. All rights reserved.
//

import Foundation

extension Step {
    enum StepType: String, CaseIterable {
        case silence, text, mantra, audio, video
    }
    
    // convert Core Data types into non-optionals and standard types
    var stepDuration: Int { Int(duration) }
    var stepOrder: Int { Int(order) }
    var stepTitle: String { title ?? "" }
    var stepType: StepType { StepType(rawValue: type ?? "silence") ?? .silence}
    
    // for SwiftUI previews and anywhere else an example Step is needed
    static var example: Step {
        let controller = DataController(inMemory: true)
        let viewContext = controller.container.viewContext
        
        let step = Step(context: viewContext)
        step.duration = 10
        step.order = 0
        step.title = "Example Step"
        step.type = StepType.silence.rawValue
        
        return step
    }
}
