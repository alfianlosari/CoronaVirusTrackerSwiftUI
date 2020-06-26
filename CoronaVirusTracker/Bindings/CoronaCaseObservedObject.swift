//
//  CoronaCaseObservedObject.swift
//  CoronaVirusTracker
//
//  Created by Alfian Losari on 05/03/20.
//  Copyright © 2020 Alfian Losari. All rights reserved.
//

import Combine
import Foundation

class CoronaCaseObservedObject: ObservableObject {
    
    let service: CoronaRepositoryService
    
    @Published var isFetching: Bool = false
    @Published var cases: [CoronaCountryCase]?
    @Published var error: CoronaAPIError?
    
    init(service: CoronaRepositoryService = CoronaArcGISService.shared) {
        self.service = service
        self.fetch()
    }
    
    func fetch() {
        isFetching = true
        error = nil
        
        service.getCases { [weak self] (result) in
            guard let self = self else { return }
            defer {
                DispatchQueue.main.async {
                    self.isFetching = false
                }
            }
            
            switch result {
            case .success(let cases):
                var dict = [String: [CoronaCase]]()
                cases.forEach { (coronaCase) in
                    guard let country = coronaCase.country else {
                        return
                    }
                    if var cases = dict[country] {
                        cases.append(coronaCase)
                        dict[country] = cases
                    } else {
                        dict[country] = [coronaCase]
                    }
                }
                dict = dict.mapValues { $0.sorted { $0.confirmed ?? 0 > $1.confirmed ?? 0 }}
                
                let countryCases = dict.map { (key, value) -> CoronaCountryCase in
                    let totalConfirmedCount = value.reduce(0) { $0 + ($1.confirmed ?? 0) }
                    let totalDeathsCount = value.reduce(0) { $0 + ($1.deaths ?? 0) }
                    let totalRecoveredCount = value.reduce(0) { $0 + ($1.recovered ?? 0) }
                    
                    return CoronaCountryCase(country: key, totalConfirmedCount: totalConfirmedCount, totalDeathCount: totalDeathsCount, totalRecoveredCount: totalRecoveredCount, cases: value)
                    
                }.sorted { $0.totalConfirmedCount > $1.totalConfirmedCount }
                
                DispatchQueue.main.async {
                    self.cases = countryCases
                }
                
            case .failure(let error):
                DispatchQueue.main.async {
                    self.error = error
                }
            }
        }
    }
    
}

