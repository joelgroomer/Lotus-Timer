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
            MyTimers().tabItem {
                Text("My Timers")
                Image(systemName: "timer")
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
