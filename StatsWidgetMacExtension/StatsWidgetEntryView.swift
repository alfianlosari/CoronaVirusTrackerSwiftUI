//
//  StatsWidgetEntryView.swift
//  CoronaVirusTracker
//
//  Created by Alfian Losari on 24/06/20.
//  Copyright © 2020 Alfian Losari. All rights reserved.
//

import SwiftUI
import WidgetKit

let confirmedColor = Color(red: 71/255, green: 97/255, blue: 244/255)
let deathColor = Color(red: 244/255, green: 114/255, blue: 114/255)
let recoveredColor = Color(red: 60/255, green: 213/255, blue: 152/255)
let sickColor = Color(red: 253/255, green: 131/255, blue: 68/255)


struct StatsWidgetEntryView : View {
    var entry: Provider.Entry
    @Environment(\.widgetFamily) var family
        
    @ViewBuilder
    var body: some View {
        switch family {
        case .systemSmall:
            VStack(alignment: .center) {
                CaseStatViewCompact(text: "Confirmed", totalCountText: entry.totalCount?.confirmedText ?? "--", color: confirmedColor)
                CaseStatViewCompact(text: "Deaths", totalCountText: entry.totalCount?.deathText ?? "--", color: deathColor)
                CaseStatViewCompact(text: "Recovered", totalCountText: entry.totalCount?.recoveredText ?? "--", color: recoveredColor)
            }
        case .systemLarge:
            VStack(spacing: 0) {
                CasePieRow(totalCount: entry.totalCount)
                CaseStatGrid(totalCount: entry.totalCount, verticalPadding: 20)
            }
            .background(Color(NSColor.controlBackgroundColor))
        default:
            CaseStatGrid(totalCount: entry.totalCount, verticalPadding: 24)
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
                    Text(totalCount?.recoveryRateText ?? "--").font(.system(size: 24, weight: .semibold)).foregroundColor(recoveredColor)
                    Text("Recovery Rate").font(.system(size: 12, weight: .regular))
                }
                
                VStack {
                    Text(totalCount?.fataliityRateText ?? "--").font(.system(size: 24, weight: .semibold)).foregroundColor(deathColor)
                    Text("Fatality Rate").font(.system(size: 12, weight: .regular))
                }
            }
            .padding(.trailing)
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
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct CaseStatViewRegular: View {
    
    let text: String
    let totalCountText: String
    let color: Color
    let verticalPadding: CGFloat
    
    var body: some View {
        VStack {
            Text(totalCountText).font(.system(size: 24, weight: .semibold))
            Text(text).font(.system(size: 12, weight: .regular))
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.vertical, verticalPadding)
        .foregroundColor(.white)
        .background(color)
    }
}

struct CaseStatViewCompact: View {
    
    let text: String
    let totalCountText: String
    let color: Color
    
    var body: some View {
        VStack {
            Text(totalCountText).font(.system(size: 24, weight: .semibold))
            Text(text).font(.system(size: 12, weight: .regular))
        }
        .frame(minWidth: 0, maxWidth: .infinity, maxHeight: .infinity)
        .padding(.horizontal)
        .foregroundColor(.white)
        .background(color)
    }
}


struct StatsWidgetEntryView_Previews: PreviewProvider {
    static var previews: some View {
        StatsWidgetEntryView(entry: CaseEntry(date: Date(), totalCount: nil))
        
    }
}

