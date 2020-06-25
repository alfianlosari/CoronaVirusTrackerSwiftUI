//
//  StatsWidgetMacExtension.swift
//  StatsWidgetMacExtension
//
//  Created by Alfian Losari on 25/06/20.
//  Copyright © 2020 Alfian Losari. All rights reserved.
//

import WidgetKit
import SwiftUI

@main
struct StatsWidgetMacExtension: Widget {
    private let kind: String = "StatsWidgetMacExtension"

    public var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider(), placeholder: PlaceholderView()) { entry in
            StatsWidgetEntryView(entry: entry)
        }
        .supportedFamilies([.systemMedium, .systemSmall, .systemLarge])
        .configurationDisplayName("Latest cases statistics")
        .description("COVID-19 Stats from WHO")
    }
}
