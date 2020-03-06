//
//  TotalCountContainerView.swift
//  CoronaVirusTracker
//
//  Created by Alfian Losari on 06/03/20.
//  Copyright © 2020 Alfian Losari. All rights reserved.
//

import SwiftUI
import UIKit

struct TotalCountContainerView: View {
    
    @ObservedObject var totalCountObserved = CoronaTotalCountObservedObject()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            if totalCountObserved.isFetching {
                ProgressView()
            } else if totalCountObserved.error != nil {
                Text("Failed to retrieve total cases count")
            } else if totalCountObserved.totalCount != nil {
                Text("Updated: \(Utils.dateFormatter.string(from: Date()))")
                    .font(.headline)
                DashboardStatsView(totalCount: totalCountObserved.totalCount!)
            }
        }
        .cardContained()
    }
}

struct DashboardStatsView: View {
    
    let totalCount: CoronaTotalCount
    
    var body: some View {
        Group {
            HStack(alignment: .center) {
                TotalCountView(totalCountText: totalCount.confirmedText, subtitleText: CoronaStatusType.confirmed.rawValue.capitalized)
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .foregroundColor(.yellow)
                
                Divider()
                
                TotalCountView(totalCountText: totalCount.deathText, subtitleText: CoronaStatusType.death.rawValue.capitalized)
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .foregroundColor(.red)
                
                Divider()
                
                TotalCountView(totalCountText: totalCount.recoveredText, subtitleText: CoronaStatusType.recovered.rawValue.capitalized)
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .foregroundColor(.green)
            }
            
            Divider()
            
            HStack(alignment: .center) {
                TotalCountView(totalCountText: totalCount.sickText, subtitleText: "Sick")
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .foregroundColor(.orange)
                Divider()
                TotalCountView(totalCountText: totalCount.recoveryRateText, subtitleText: "Recovery rate")
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .foregroundColor(.green)
                Divider()
                TotalCountView(totalCountText: totalCount.fataliityRateText, subtitleText: "Fatality rate")
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .foregroundColor(.red)
            }
        }
    }
    
}
