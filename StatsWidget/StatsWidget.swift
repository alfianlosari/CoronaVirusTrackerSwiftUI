//
//  StatsWidget.swift
//  StatsWidget
//
//  Created by Alfian Losari on 23/06/20.
//  Copyright © 2020 Alfian Losari. All rights reserved.
//

import WidgetKit
import SwiftUI


struct Provider: TimelineProvider {
    public typealias Entry = CaseEntry
    private let service = CoronaArcGISService.shared
    
    public func snapshot(with context: Context, completion: @escaping (CaseEntry) -> ()) {
        if context.isPreview {
            let entry = CaseEntry(date: Date(), totalCount: nil)
            completion(entry)
        } else {
            service.getAllTotalCount { (result) in
                switch result {
                case .success(let totalCount):
                    let entry = CaseEntry(date: Date(), totalCount: totalCount)
                    completion(entry)
                    
                case .failure(let error):
                    let entry = CaseEntry(date: Date(), totalCount: nil)
                    completion(entry)
                }
            }
        }
        
        
    }
    
    public func timeline(with context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        service.getAllTotalCount { (result) in
            switch result {
            case .success(let totalCount):
                let timeline = Timeline(entries: [CaseEntry(date: Date(), totalCount: totalCount)], policy: .atEnd)
                completion(timeline)
                
            case .failure(let error):
                print(error.localizedDescription)
                let timeline = Timeline(entries: [CaseEntry(date: Date(), totalCount: nil)], policy: .atEnd)
                completion(timeline)
            }
        }
    }
    
}

struct CaseEntry: TimelineEntry {
    public let date: Date
    public let totalCount: CoronaTotalCount?
}

struct PlaceholderView : View {
    var body: some View {
        StatsWidgetEntryView(entry: CaseEntry(date: Date(), totalCount: nil))
    }
}

@main
struct StatsWidget: Widget {
    private let kind: String = "StatsWidget"
    
    public var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider(), placeholder: PlaceholderView()) { entry in
            StatsWidgetEntryView(entry: entry)
        }
        .supportedFamilies([.systemMedium, .systemSmall, .systemLarge])
        .configurationDisplayName("Latest cases statistics")
        .description("COVID-19 Stats from WHO")
    }
}

struct StatsWidget_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
