//
//  View+Extension.swift
//  CoronaVirusTracker
//
//  Created by Alfian Losari on 07/03/20.
//  Copyright © 2020 Alfian Losari. All rights reserved.
//

import SwiftUI

extension View {
    
    func cardContained(cornerRadius: CGFloat = 8) -> some View {
        self
        .padding(.all)
        .background(Color(UIColor.systemBackground))
        .cornerRadius(cornerRadius)
    }
}
