//
//  ContentView.swift
//  CoronaVirusTrackerMac
//
//  Created by Alfian Losari on 25/06/20.
//  Copyright © 2020 Alfian Losari. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            SidebarMenuView()
                .frame(minWidth: 200, maxWidth: 200, maxHeight: .infinity)
            StatsView()
        }
        .frame(minWidth: 1000, maxWidth: .infinity, minHeight: 560, maxHeight: .infinity)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
