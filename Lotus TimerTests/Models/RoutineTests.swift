//
//  RoutineTests.swift
//  Lotus TimerTests
//
//  Created by Joel Groomer on 11/25/20.
//

import XCTest
import CoreData
import SwiftUI
@testable import Lotus_Timer

class RoutineTests: XCTestCase {

    var dataController = DataController()
    
    override func setUpWithError() throws {
        let context: NSManagedObjectContext = dataController.moc
        dataController.deleteAll()
        let routine = Routine(context: context)
        routine.author = "Author"
        routine.category = "Category"
        routine.listOrder = 0
        routine.origin = Routine.Origin.user.rawValue
        dataController.save()
        
    }

    override func tearDownWithError() throws {
        
    }

    func testCreatedOneRoutine() throws {
        let context: NSManagedObjectContext = dataController.moc
        let fetchRequest = NSFetchRequest<NSNumber>(entityName: "Routine")
        fetchRequest.resultType = .countResultType
        
        do {
            let result = try context.fetch(fetchRequest)
            let count = result.first!.intValue
            print(count)
            XCTAssert(count == 1)
        } catch {
            XCTFail("Count was not 1 after creating one Routine: \(error.localizedDescription)")
        }
        
    }

    func testRoutineValues() throws {
        let context: NSManagedObjectContext = dataController.moc
        let fetchRequest: NSFetchRequest<Routine> = Routine.fetchRequest()
        
        do {
            let results = try context.fetch(fetchRequest)
            let routine = results[0]
            XCTAssert(routine.author == "Author")
            XCTAssert(routine.category == "Category")
            XCTAssert(routine.listOrder == 0)
            XCTAssert(routine.origin == Routine.Origin.user.rawValue)
        } catch {
            XCTFail("Failed to fetch Routine: \(error.localizedDescription)")
        }
        
        
    }

}

