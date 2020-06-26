//
//  AboutView.swift
//  CoronaVirusTracker
//
//  Created by Alfian Losari on 06/03/20.
//  Copyright © 2020 Alfian Losari. All rights reserved.
//

import SwiftUI

struct AboutView: View {
    
    let about: About = About.defaultAbout
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 32) {
                    Text(about.title)
                        .font(.body)
                        .cardContained()
                    ForEach(about.copyrights) { copy in
                        VStack(alignment: .leading, spacing: 8) {
                            SectionCardView(title: copy.title, subtitle: copy.license)
                        }
                    }
                }
                .padding(.all)
            }
            .navigationBarTitle("About", displayMode: .inline)
            .background(Color(UIColor.secondarySystemBackground))
        }
    }
}

