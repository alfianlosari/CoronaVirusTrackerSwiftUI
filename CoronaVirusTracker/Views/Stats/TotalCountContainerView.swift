//
//  TotalCountContainerView.swift
//  CoronaVirusTracker
//
//  Created by Alfian Losari on 06/03/20.
//  Copyright © 2020 Alfian Losari. All rights reserved.
//

import SwiftUI


let confirmedColor = Color(red: 71/255, green: 97/255, blue: 244/255)
let deathColor = Color(red: 244/255, green: 114/255, blue: 114/255)
let recoveredColor = Color(red: 60/255, green: 213/255, blue: 152/255)
let sickColor = Color(red: 253/255, green: 131/255, blue: 68/255)

struct TotalCountContainerView: View {
    
    @ObservedObject var totalCountObserved = CoronaTotalCountObservedObject()
    
    var body: some View {
        VStack(spacing: 0) {
            CasePieRow(totalCount: totalCountObserved .totalCount)
        }
    }
}

struct CasePieRow: View {
    
    let totalCount: CoronaTotalCount?
    
    var body: some View {
        HStack {
            if let totalCount = totalCount {
                PieChartView(
                    data: [(Double(totalCount.sick), sickColor), (Double(totalCount.death), deathColor), (Double(totalCount.recovered), recoveredColor)],
                    style: Styles.pieChartStyleOne,
                    form: CGSize(width: 200, height: 160),
                    dropShadow: false
                )
            } else {
                Circle().fill(Color.gray.opacity(0.3)).frame(width: 200, height: 160)
            }
                        
            VStack(spacing: 16) {
                VStack {
                    Text(totalCount?.recoveryRateText ?? "--").font(.system(size: 36, weight: .semibold)).foregroundColor(recoveredColor)
                    Text("Recovery Rate").font(.system(size: 14, weight: .regular))
                }
                
                VStack {
                    Text(totalCount?.fataliityRateText ?? "--").font(.system(size: 36, weight: .semibold)).foregroundColor(deathColor)
                    Text("Fatality Rate").font(.system(size: 14, weight: .regular))
                }
            }
            
            Divider()
                .frame(height: 200)
            
            
            CaseStatGrid(totalCount: totalCount, verticalPadding: 16)
                .cornerRadius(8)
                .padding(.horizontal)
                .frame(maxWidth: .infinity)
        }
        .padding()
    }
}

struct CaseStatGrid: View {
    
    let totalCount: CoronaTotalCount?
    let verticalPadding: CGFloat
    let columns: [GridItem] = Array(repeating: .init(.flexible(), spacing: 0), count: 2)
    
    var body: some View {
        
        LazyVGrid(columns: columns, alignment: .center, spacing: 0) {
            CaseStatViewRegular(text: "Confirmed", totalCountText: totalCount?.confirmedText ?? "--", color: confirmedColor, verticalPadding: verticalPadding)
            CaseStatViewRegular(text: "Deaths", totalCountText: totalCount?.deathText ?? "--", color: deathColor, verticalPadding: verticalPadding)
            CaseStatViewRegular(text: "Sick", totalCountText: totalCount?.sickText ?? "--", color: sickColor, verticalPadding: verticalPadding)
            CaseStatViewRegular(text: "Recovered", totalCountText: totalCount?.recoveredText ?? "--", color: recoveredColor, verticalPadding: verticalPadding)
        }
    }
}

struct CaseStatViewRegular: View {
    
    let text: String
    let totalCountText: String
    let color: Color
    let verticalPadding: CGFloat
    
    var body: some View {
        VStack {
            Text(totalCountText).font(.system(size: 28, weight: .semibold))
            Text(text).font(.system(size: 14, weight: .regular))
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.vertical, verticalPadding)
        .foregroundColor(.white)
        .background(color)
    }
}
