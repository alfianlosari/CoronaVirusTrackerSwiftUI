//
//  PieChartRow.swift
//  ChartView
//
//  Created by András Samu on 2019. 06. 12..
//  Copyright © 2019. András Samu. All rights reserved.
//

import SwiftUI

public struct PieChartRow : View {
    var data: [(value: Double, color: Color)]
    var backgroundColor: Color
    var accentColor: Color
    var slices: [PieSlice] {
        var tempSlices:[PieSlice] = []
        var lastEndDeg:Double = 0
        let values = data.map { $0.value }
        let maxValue = values.reduce(0, +)
        for slice in data {
            let normalized:Double = Double(slice.value)/Double(maxValue)
            let startDeg = lastEndDeg
            let endDeg = lastEndDeg + (normalized * 360)
            lastEndDeg = endDeg
            tempSlices.append(PieSlice(startDeg: startDeg, endDeg: endDeg, value: slice.value, normalizedValue: normalized, color: slice.color))
        }
        return tempSlices
    }
    
    public var body: some View {
        GeometryReader { geometry in
            ZStack{
                ForEach(Array(self.slices.enumerated()), id: \.offset) { i in
                    PieChartCell(rect: geometry.frame(in: .local), startDeg: self.slices[i.offset].startDeg, endDeg: self.slices[i.offset].endDeg, index: i.offset, backgroundColor: self.backgroundColor,accentColor: self.slices[i.offset].color)
                }
            }
        }
    }
}
