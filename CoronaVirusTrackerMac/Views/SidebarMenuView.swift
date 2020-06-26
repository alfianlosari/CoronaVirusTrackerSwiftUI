//
//  SidebarMenuView.swift
//  CoronaVirusTrackerMac
//
//  Created by Alfian Losari on 25/06/20.
//  Copyright © 2020 Alfian Losari. All rights reserved.
//

import SwiftUI

struct SidebarMenuView: View {
    
    @State var selection: String?
    
    private func view(for menu: Menu) -> some View {
        switch menu {
        case .stats: return AboutView()
        case .maps: return AboutView()
        case .advices: return AboutView()
        case .about: return AboutView()
        }
    }
    
    var body: some View {
        List(selection: $selection) {
            ForEach(Menu.allCases, id: \.self) { menu in
                switch menu {
                case .stats:
                    NavigationLink(destination: StatsView()) {
                        Label(menu.rawValue.capitalized, systemImage: menu.systemImage)
                    }.tag(menu.rawValue)
                    
                case .advices:
                    NavigationLink(destination: AdvicesView()) {
                        Label(menu.rawValue.capitalized, systemImage: menu.systemImage)
                    }.tag(menu.rawValue)
                    
                case .maps:
                    NavigationLink(destination: MapsView()) {
                        Label(menu.rawValue.capitalized, systemImage: menu.systemImage)
                    }.tag(menu.rawValue)
                    
                case .about:
                    NavigationLink(destination: AboutView()) {
                        Label(menu.rawValue.capitalized, systemImage: menu.systemImage)
                    }.tag(menu.rawValue)
                }
            }
        }
        .listStyle(SidebarListStyle())
    }
}

enum Menu: String, CaseIterable {
    
    case stats
    case maps
    case advices
    case about
        
    var systemImage: String {
        switch self {
        case .stats: return "chart.pie"
        case .maps: return "map"
        case .advices: return "tray.fill"
        case .about: return "person"
        }
    }
}

struct SidebarMenuView_Previews: PreviewProvider {
    static var previews: some View {
        SidebarMenuView()
    }
}
