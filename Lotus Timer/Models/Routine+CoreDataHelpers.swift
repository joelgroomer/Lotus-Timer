//
//  Routine+CoreDataHelpers.swift
//  Lotus Timer
//
//  Created by Joel Groomer on 11/21/20.
//  Copyright © 2020 Julltron. All rights reserved.
//

import CoreData

extension Routine {
    enum Origin: String {
        case user, downloaded
    }
    
    // convert Core Data types into non-optionals and standard types
    var routineAuthor: String { author ?? "" }
    var routineCategory: String { category ?? "" }
    var routineOrder: Int { Int(listOrder) }
    var routineOrigin: Origin {
        get {
            Origin(rawValue: origin ?? "user") ?? .user
        }
        
        set {
            self.origin = newValue.rawValue
        }
    }
    var routineTitle: String { title ?? "New routine" }
    
    // convert set of Steps associated with this Routine into an array of Steps
    var routineSteps: [Step] {
        let stepsArray = steps?.allObjects as? [Step] ?? []
        return stepsArray.sorted { $0.stepOrder < $1.stepOrder }
    }
    
    
    // for SwiftUI previews and anywhere else an example Routine is needed
    static var example: Routine {
        let controller = DataController(inMemory: true)
        let viewContext = controller.container.viewContext
        
        let routine = Routine(context: viewContext)
        routine.author = "User"
        routine.category = "Some category"
        routine.listOrder = 0
        routine.origin = Origin.user.rawValue
        routine.title = "Example Routine"
        
        return routine
    }
    
}
