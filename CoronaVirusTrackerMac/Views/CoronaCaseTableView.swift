//
//  CoronaCaseTableView.swift
//  CoronaVirusTrackerMac
//
//  Created by Alfian Losari on 26/06/20.
//  Copyright © 2020 Alfian Losari. All rights reserved.
//

import SwiftUI

struct CoronaCaseTableView: View {
    
    @EnvironmentObject var caseObservable: CoronaCaseObservedObject
    
    var body: some View {
        LazyVStack(alignment: .leading, spacing: 16) {
            if caseObservable.isFetching {
                Text("Loading")
            } else if caseObservable.error != nil {
                Text("Error")
            } else if caseObservable.cases != nil {
                ForEach(caseObservable.cases!) { coronaCase in
                    CoronaCaseRowView(title: coronaCase.country, totalCount: coronaCase.coronaTotalCount)
                }
            }
        }
    }
    
}

struct CoronaCaseRowView: View {
    
    let title: String
    let totalCount: CoronaTotalCount
    
    var body: some View {
        HStack(alignment: .top) {
            Text(title)
                .frame(maxWidth: .infinity, alignment: .leading)
            Text(totalCount.confirmedText)
                .frame(width: 100)
            Text(totalCount.deathText)
                .frame(width: 100)
            Text(totalCount.recoveredText)
                .frame(width: 100)
            
        }
        .fixedSize(horizontal: false, vertical: true)
    }
    
}

struct CoronaCaseTableView_Previews: PreviewProvider {
    static var previews: some View {
        CoronaCaseTableView()
    }
}
