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
                
                HStack(alignment: .center) {
                    TotalCountView(totalCountText: totalCountObserved.totalCount!.confirmedText, subtitleText: CoronaStatusType.confirmed.rawValue.capitalized)
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .foregroundColor(.yellow)
                    
                    Divider()
                    
                    TotalCountView(totalCountText: totalCountObserved.totalCount!.deathText, subtitleText: CoronaStatusType.death.rawValue.capitalized)
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .foregroundColor(.red)
                    
                    Divider()
                    
                    TotalCountView(totalCountText: totalCountObserved.totalCount!.recoveredText, subtitleText: CoronaStatusType.recovered.rawValue.capitalized)
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .foregroundColor(.green)
                }
                
                Divider()
                
                HStack(alignment: .center) {
                    TotalCountView(totalCountText: totalCountObserved.totalCount!.sickText, subtitleText: "Sick")
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .foregroundColor(.orange)
                    Divider()
                    TotalCountView(totalCountText: totalCountObserved.totalCount!.recoveryRateText, subtitleText: "Recovery rate")
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .foregroundColor(.green)
                    Divider()
                    TotalCountView(totalCountText: totalCountObserved.totalCount!.fataliityRateText, subtitleText: "Fatality rate")
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .foregroundColor(.red)
                }
            }
        }
        .padding(.horizontal)
        .padding(.vertical)
        .background(Color(UIColor.systemBackground))
        .cornerRadius(8)

    }
}
