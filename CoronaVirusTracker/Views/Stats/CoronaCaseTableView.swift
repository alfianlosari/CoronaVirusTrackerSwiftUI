//
//  CoronaCaseTableView.swift
//  CoronaVirusTracker
//
//  Created by Alfian Losari on 06/03/20.
//  Copyright © 2020 Alfian Losari. All rights reserved.
//

import SwiftUI
import UIKit

struct CoronaCaseTableView: View {
    
    @EnvironmentObject var caseObservable: CoronaCaseObservedObject
    @Binding var searchTerm : String

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack() {
                Text("Country")
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
            
            if caseObservable.isFetching {
                Text("Loading")
            } else if caseObservable.error != nil {
                Text("Error")
            } else if caseObservable.cases != nil {
                ForEach(caseObservable.cases!.filter {
                    self.searchTerm.isEmpty ? true : $0.country.localizedStandardContains(self.searchTerm)
                }) { coronaCase in
                    if coronaCase.cases.count > 1 {
                        NavigationLink(destination: CoronaCountryView(coronaCase: coronaCase)) {
                            CoronaCaseRowView(title: coronaCase.country, totalCount: coronaCase.coronaTotalCount)
                        }
                    } else {
                        CoronaCaseRowView(title: coronaCase.country, totalCount: coronaCase.coronaTotalCount)
                    }
                }
            }
        }
        .padding(.all)
        .background(Color(UIColor.systemBackground))
        .cornerRadius(8)
    }
    
}

struct CoronaCaseRowView: View {
    
    let title: String
    let totalCount: CoronaTotalCount
    
    var body: some View {
        HStack(alignment: .top) {
            Text(title)
                .frame(maxWidth: .infinity, alignment: .leading)
            Divider()
            Text(totalCount.confirmedText)
                .frame(width: 60)
            Divider()
            Text(totalCount.deathText)
                .frame(width: 60)
            Divider()
            Text(totalCount.recoveredText)
                .frame(width: 60)
            
        }
        .fixedSize(horizontal: false, vertical: true)
    }
        
}
