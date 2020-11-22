//
//  DataController.swift
//  Lotus Timer
//
//  Created by Joel Groomer on 11/21/20.
//  Copyright © 2020 Julltron. All rights reserved.
//

import CoreData
import SwiftUI

class DataController: ObservableObject {
    let container: NSPersistentCloudKitContainer
    
    init(inMemory: Bool = false) {
        container = NSPersistentCloudKitContainer(name: "Main")
        
        if inMemory {
            // Write data to null so that it only persists for one session
            // This is useful for testing purposes
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }
        
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error {
                fatalError("Fatal error loading store: \(error.localizedDescription)")
            }
        }
    }
    
    static var preview: DataController = {
        let dataController = DataController(inMemory: true)
        
        do {
            try dataController.createSampleData()
        } catch {
            fatalError("Fatal error creating preview: \(error.localizedDescription)")
        }
        
        return dataController
    }()
    
    func createSampleData() throws {
        let viewContext = container.viewContext
        
        for i in 1...5 {
            let routine = Routine(context: viewContext)
            routine.author = "User"
            routine.category = "A category"
            routine.listOrder = Int16(i - 1)
            routine.origin = Routine.Origin.user.rawValue
            routine.title = "Routine \(i)"
            
            for j in 1...10 {
                let step = Step(context: viewContext)
                step.duration = Int16(j * 10)
                step.order = Int16(j - 1)
                step.title = "Step \(j)"
                step.type = Step.StepType.allCases.randomElement()!.rawValue
                step.routine = routine  // add this Step to the above Routine
            }
        }
        
        try viewContext.save()
    }
    
    func save() {
        if container.viewContext.hasChanges {
            try? container.viewContext.save()
        }
    }
    
    func delete(_ object: NSManagedObject) {
        container.viewContext.delete(object)
    }
    
    func deleteAll() {
        // delete all Steps
        let fetchRequestSteps: NSFetchRequest<NSFetchRequestResult> = Step.fetchRequest()
        let batchDeleteRequestSteps = NSBatchDeleteRequest(fetchRequest: fetchRequestSteps)
        _ = try? container.viewContext.execute(batchDeleteRequestSteps)
        
        // delete all Routines
        let fetchRequestRoutines: NSFetchRequest<NSFetchRequestResult> = Routine.fetchRequest()
        let batchDeleteRequestRoutines = NSBatchDeleteRequest(fetchRequest: fetchRequestRoutines)
        _ = try? container.viewContext.execute(batchDeleteRequestRoutines)
    }
}
