//
//  View+Extension.swift
//  CoronaVirusTracker
//
//  Created by Alfian Losari on 07/03/20.
//  Copyright © 2020 Alfian Losari. All rights reserved.
//

import SwiftUI

extension View {
    
    var cardContainedColor: Color {
        #if os(iOS)
        return Color(UIColor.systemBackground)
        #elseif os(macOS)
        return Color(NSColor.controlBackgroundColor)
        #endif
    }
    
    func cardContained(cornerRadius: CGFloat = 8) -> some View {
        self
        .padding(.all)
        .background(cardContainedColor)
        .cornerRadius(cornerRadius)
    }
    
    func navigationTitle(title: String) -> some View {
        #if os(iOS)
        return self.navigationBarTitle(topic.title, displayMode: .inline)
        #elseif os(macOS)
        return self
        #endif
    }
}
