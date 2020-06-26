//
//  StatsView.swift
//  CoronaVirusTrackerMac
//
//  Created by Alfian Losari on 25/06/20.
//  Copyright © 2020 Alfian Losari. All rights reserved.
//

import SwiftUI

struct StatsView: View {
    
    @EnvironmentObject var caseObservable: CoronaCaseObservedObject
    
    var body: some View {
        ZStack {
            VStack {
                Text("COVID-19 Global Cases Stats")
                    .font(.title)
                TotalCountContainerView()
                Divider()
                
                HStack {
                    Text("Country")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("Conf.")
                        .frame(width: 100)
                    Text("Death")
                        .frame(width: 100)
                    Text("Rec.")
                        .frame(width: 100)
                }
                .font(.headline)
                .padding(.horizontal)
                .frame(width: 512)

                Divider()
                
                ScrollView {
                    CoronaCaseTableView()
                }
                .padding(.horizontal)
                .frame(width: 512)
            }
            .frame(maxWidth: 768)
        }
        .padding([.top, .horizontal])
        .background(Color(NSColor.controlBackgroundColor))
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .edgesIgnoringSafeArea(.top)
        .onAppear {
            caseObservable.fetch()
        }
    }
}

struct StatsView_Previews: PreviewProvider {
    static var previews: some View {
        StatsView()
    }
}
