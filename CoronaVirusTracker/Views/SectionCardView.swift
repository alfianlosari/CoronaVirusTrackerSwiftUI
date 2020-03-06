//
//  SectionCardView.swift
//  CoronaVirusTracker
//
//  Created by Alfian Losari on 07/03/20.
//  Copyright © 2020 Alfian Losari. All rights reserved.
//

import SwiftUI

struct SectionCardView: View {
    
    let title: String
    let subtitle: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.headline)
            Text(subtitle)
                .font(.body)
                .cardContained()
        }
    }
    
}

