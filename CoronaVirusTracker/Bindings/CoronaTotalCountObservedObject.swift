//
//  CoronaTotalCountObservedObject.swift
//  CoronaVirusTracker
//
//  Created by Alfian Losari on 04/03/20.
//  Copyright © 2020 Alfian Losari. All rights reserved.
//

import Combine
import Foundation

class CoronaTotalCountObservedObject: ObservableObject {
    
    let service: CoronaRepositoryService
    
    @Published var isFetching: Bool = false
    @Published var totalCount: CoronaTotalCount?
    @Published var error: CoronaAPIError?
    
    init(service: CoronaRepositoryService = CoronaArcGISService.shared) {
        self.service = service
        self.fetch()
    }
    
    func fetch() {
        isFetching = true
        error = nil
        
        service.getAllTotalCount { [weak self](result) in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.isFetching = false
                switch result {
                case .success(let totalCount):
                    self.totalCount = totalCount
                case .failure(let error):
                    self.error = error
                }
            }
        }
        
    }
    
}
