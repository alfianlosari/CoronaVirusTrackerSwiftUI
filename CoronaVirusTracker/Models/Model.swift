//
//  Model.swift
//  CoronaVirusTracker
//
//  Created by Alfian Losari on 06/03/20.
//  Copyright © 2020 Alfian Losari. All rights reserved.
//

import Foundation

enum CoronaStatusType: String {
    case confirmed
    case death
    case recovered
    
    static var caseWhereQuery: String {
        "(Confirmed> 0) OR (Deaths>0) OR (Recovered>0)"
    }
    
    static var caseOrderByFieldsQuery: String {
        "Country_Region asc,Province_State asc"
    }
    
    var outStatisticForSumQuery: String {
        let field = self == .death ? "Deaths" : rawValue.capitalized
        return "[{\"statisticType\":\"sum\",\"onStatisticField\":\"\(field)\",\"outStatisticFieldName\":\"value\"}]"
    }
    
    var totalCountWhereQuery: String {
        let field = self == .recovered ? self.rawValue : CoronaStatusType.confirmed.rawValue
        return "\(field.capitalized) > 0"
    }
}

struct CoronaTotalCount {
    var confirmed: Int
    var death: Int
    var recovered: Int
    
    var confirmedText: String {
        Utils.numberFormatter.string(from: NSNumber(value: confirmed)) ?? "0"
    }
    
    var deathText: String {
        Utils.numberFormatter.string(from: NSNumber(value: death)) ?? "0"
    }
    
    var recoveredText: String {
        Utils.numberFormatter.string(from: NSNumber(value: recovered)) ?? "0"
    }
    
    var sick: Int {
        confirmed - death - recovered
    }
    
    var recoveryRate: Double {
        (Double(recovered) / Double(confirmed)) * 100
    }
    
    var fatalityRate: Double {
        (Double(death) / Double(confirmed)) * 100
    }
    
    var sickText: String {
        Utils.numberFormatter.string(from: NSNumber(value: sick)) ?? "0"
    }
    
    var recoveryRateText: String {
        (Utils.numberFormatter.string(from: NSNumber(value: recoveryRate)) ?? "0") + "%"
    }
    
    var fataliityRateText: String {
        (Utils.numberFormatter.string(from: NSNumber(value: fatalityRate)) ?? "0") + "%"
    }
    
}

struct CoronaCaseResponse: Decodable {
    
    let features: [CoronaCaseFeatures]
    
    struct CoronaCaseFeatures: Decodable {
        let attributes: CoronaCase
    }
    
}

struct CoronaTotalCountResponse: Decodable {
    
    let features: [CoronaTotalCountFeatures]
    
    struct CoronaTotalCountFeatures: Decodable {
        let attributes: CoronaTotalCountAttributes
    }
    struct CoronaTotalCountAttributes: Decodable {
        let value: Int
    }
}

struct CoronaCase: Decodable {
    
    let id: Int
    let state: String?
    let country: String
    let lastUpdatedAt: Date
    let latitude: Double
    let longitude: Double
    let confirmed: Int
    let deaths: Int
    let recovered: Int
    
    var confirmedText: String {
        Utils.numberFormatter.string(from: NSNumber(value: confirmed)) ?? "0"
    }
    
    var deathText: String {
        Utils.numberFormatter.string(from: NSNumber(value: deaths)) ?? "0"
    }
    
    var recoveredText: String {
        Utils.numberFormatter.string(from: NSNumber(value: recovered)) ?? "0"
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "OBJECTID"
        case state = "Province_State"
        case country = "Country_Region"
        case lastUpdatedAt = "Last_Update"
        case latitude = "Lat"
        case longitude = "Long_"
        case confirmed = "Confirmed"
        case deaths = "Deaths"
        case recovered = "Recovered"
    }
    
}

extension CoronaCase: Identifiable {}

struct WHOAdvice: Decodable, Identifiable {
    
    let id = UUID()
    
    let title: String
    let subtitle: String
    let basics: [WHOData]
    let topics: [WHOTopic]
    
}

struct WHOTopic: Decodable, Identifiable {
    
    let id = UUID()
    
    let title: String
    let questions: [WHOData]
}


struct WHOData: Decodable, Identifiable {
    
    let id = UUID()
    
    let title: String
    let subtitle: String
}


struct CoronaCountryCase: Identifiable {
    
    var id: String { country }
    let country: String
    let totalConfirmedCount: Int
    let totalDeathCount: Int
    let totalRecoveredCount: Int
    let cases: [CoronaCase]
    
    var coronaTotalCount: CoronaTotalCount {
        CoronaTotalCount(confirmed: totalConfirmedCount, death: totalDeathCount, recovered: totalRecoveredCount)
    }
}
