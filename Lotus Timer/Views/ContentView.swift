//
//  ContentView.swift
//  Lotus Timer
//
//  Created by Joel Groomer on 7/4/20.
//  Copyright © 2020 Julltron. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            MyRoutines().tabItem {
                Text("My Routines")
                Image(systemName: "list.bullet")
            }
            QuickStart().tabItem {
                Text("Quick Start")
                Image(systemName: "hare")
            }
            More().tabItem {
                Text("More")
                Image(systemName: "ellipsis.circle")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
