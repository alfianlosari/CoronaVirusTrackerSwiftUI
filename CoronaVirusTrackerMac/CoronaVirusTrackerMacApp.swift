//
//  CoronaVirusTrackerMacApp.swift
//  CoronaVirusTrackerMac
//
//  Created by Alfian Losari on 25/06/20.
//  Copyright © 2020 Alfian Losari. All rights reserved.
//

import WidgetKit
import SwiftUI


@main
struct CoronaVirusTrackerMacApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onAppear {
                    WidgetCenter.shared.reloadAllTimelines()
                }
                
        }
        
    }
}
