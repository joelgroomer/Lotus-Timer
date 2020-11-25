//
//  MyRoutinesView.swift
//  Lotus Timer
//
//  Created by Joel Groomer on 7/5/20.
//  Copyright © 2020 Julltron. All rights reserved.
//

import SwiftUI

struct MyRoutines: View {
    @EnvironmentObject var dataController: DataController
    @Environment(\.managedObjectContext) var context
    
    let routines: FetchRequest<Routine>
    
    init() {
        routines = FetchRequest<Routine>(entity: Routine.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Routine.listOrder, ascending: true)])
    }
    
    var body: some View {
        VStack {
            Text("My Routines")
                .font(.title)
            Button {
                try? dataController.createSampleData()
            } label: {
                Text("Create sample data")
            }
            Button {
                dataController.deleteAll()
            } label: {
                Text("Delete all")
                    .foregroundColor(.red)
            }
            List {
                ForEach(routines.wrappedValue) { routine in
                    Text(routine.routineTitle)
                }
            }
        }
    }
}

struct MyTimersView_Previews: PreviewProvider {
    static var previews: some View {
        MyRoutines()
    }
}
