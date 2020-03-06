//
//  ContentView.swift
//  CoronaVirusTracker
//
//  Created by Alfian Losari on 04/03/20.
//  Copyright © 2020 Alfian Losari. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        TabView {
            StatsView()
                .tabItem {
                    VStack {
                        Image(systemName: "chart.bar")
                        Text("Stats")
                    }
            }
            .tag(0)
            
            ContainerMapView()
                .edgesIgnoringSafeArea(.vertical)
                .tabItem {
                    VStack {
                        Image(systemName: "map")
                        
                        Text("Maps")
                    }
            }.tag(1)
            
            AdviceView()
                .tabItem {
                    VStack {
                        Image(systemName: "tray.full")
                        Text("Advices")
                    }
            }
            .tag(2)
            
            AboutView()
                .tabItem {
                    VStack {
                        Image(systemName: "person")
                        Text("About")
                    }
            }
            .tag(2)
        }
        .edgesIgnoringSafeArea(.top)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environment(\.colorScheme, .dark)
    }
}
