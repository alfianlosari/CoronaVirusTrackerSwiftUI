//
//  AboutView.swift
//  CoronaVirusTracker
//
//  Created by Alfian Losari on 06/03/20.
//  Copyright © 2020 Alfian Losari. All rights reserved.
//

import SwiftUI
import UIKit

struct AboutView: View {
    
    let about: About = About.defaultAbout
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 32) {
                  Text(about.title)
                        .font(.body)
                        .padding(.all)
                        .background(Color(UIColor.systemBackground))
                        .cornerRadius(8)
                    
                    ForEach(about.copyrights) { copy in
                        VStack(alignment: .leading, spacing: 8) {
                            Text(copy.title)
                                .font(.title)
                            Text(copy.license)
                                .font(.body)
                                .padding(.all)
                                .background(Color(UIColor.systemBackground))
                                .cornerRadius(8)
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
