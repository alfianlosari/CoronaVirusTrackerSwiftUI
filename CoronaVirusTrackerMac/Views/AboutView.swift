//
//  AboutView.swift
//  CoronaVirusTrackerMac
//
//  Created by Alfian Losari on 25/06/20.
//  Copyright © 2020 Alfian Losari. All rights reserved.
//

import SwiftUI

struct AboutView: View {
    
    let about: About = About.defaultAbout

    var body: some View {
        
        ScrollView {
            LazyVStack(alignment: .leading, spacing: 32) {
                SectionCardView(title: "About", subtitle: about.title)
                ForEach(about.copyrights) { copy in
                    VStack(alignment: .leading, spacing: 8) {
                        SectionCardView(title: copy.title, subtitle: copy.license)
                    }
                }
            }
            .padding(.all)
            .frame(maxWidth: 768)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}
