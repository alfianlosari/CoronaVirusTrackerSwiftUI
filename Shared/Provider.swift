//
//  Provider.swift
//  CoronaVirusTracker
//
//  Created by Alfian Losari on 25/06/20.
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
                    print(error.localizedDescription)
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
                let timeline = Timeline(entries: [CaseEntry(date: Date(), totalCount: totalCount)], policy: .after(Date().addingTimeInterval(1800)))
                completion(timeline)
                
            case .failure(let error):
                print(error.localizedDescription)
                let timeline = Timeline(entries: [CaseEntry(date: Date(), totalCount: nil)], policy: .after(Date().addingTimeInterval(30)))
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
