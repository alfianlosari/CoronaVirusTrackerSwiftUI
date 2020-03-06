//
//  CoronaCountryView.swift
//  CoronaVirusTracker
//
//  Created by Alfian Losari on 05/03/20.
//  Copyright © 2020 Alfian Losari. All rights reserved.
//

import SwiftUI

struct CoronaCountryView: View {
    
    let coronaCase: CoronaCountryCase
    
    var body: some View {
        ScrollView {
            TotalCountCountryContainerView(totalCount: coronaCase.coronaTotalCount)
                .padding(.top)
                .padding(.horizontal)
            
            CoronaCaseRegionView(cases: coronaCase.cases)
                .padding(.all)
        }
        .navigationBarTitle(coronaCase.country)
        .background(Color(UIColor.secondarySystemBackground))
    }
}

struct TotalCountCountryContainerView: View {
    
    let totalCount: CoronaTotalCount
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            DashboardStatsView(totalCount: totalCount)
        }
        .cardContained()
    }
}

struct CoronaCaseRegionView: View {
    
    let cases: [CoronaCase]
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack() {
                Text("Region")
                    .frame(maxWidth: .infinity, alignment: .leading)
                Divider()
                Text("Conf.")
                    .frame(width: 60)
                Divider()
                Text("Death")
                    .frame(width: 60)
                Divider()
                Text("Rec.")
                    .frame(width: 60)
            }
            .font(.headline)
            Divider()
            ForEach(cases) { CoronaCaseRegionDetailView(coronaCase: $0) }
        }
        .cardContained()
    }
}

struct CoronaCaseRegionDetailView: View {
    
    let coronaCase: CoronaCase
    var body: some View {
        HStack(alignment: .top) {
            Text(coronaCase.state ?? "")
                .frame(maxWidth: .infinity, alignment: .leading)
            Divider()
            Text(coronaCase.confirmedText)
                .frame(width: 60)
            Divider()
            Text(coronaCase.deathText)
                .frame(width: 60)
            Divider()
            Text(coronaCase.recoveredText)
                .frame(width: 60)
        }
        .fixedSize(horizontal: false, vertical: true)
    }
}


