//
//  ContentView.swift
//  CoronaVirusTracker
//
//  Created by Alfian Losari on 04/03/20.
//  Copyright © 2020 Alfian Losari. All rights reserved.
//

import SwiftUI

private struct Tab: View {
    let imageName: String
    let text: String
    
    var body: some View {
        VStack {
            Image(systemName: imageName)
            Text(text)
        }
    }
}

struct ContentView: View {
    var body: some View {
        TabView {
            StatsView()
                .tabItem {
                    Tab(imageName: "chart.bar", text: "stats")
            }
            .tag(0)
            
            ContainerMapView()
                .edgesIgnoringSafeArea(.vertical)
                .tabItem {
                    Tab(imageName: "map", text: "Maps")
            }
            .tag(1)
            
            AdviceView()
                .tabItem {
                    Tab(imageName: "tray.full", text: "Advices")
            }
            .tag(2)
            
            AboutView()
                .tabItem {
                    Tab(imageName: "person", text: "About")
            }
            .tag(3)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environment(\.colorScheme, .dark)
    }
}

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
