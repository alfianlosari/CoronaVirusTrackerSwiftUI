//
//  CoronaAPIService.swift
//  CoronaVirusTracker
//
//  Created by Alfian Losari on 04/03/20.
//  Copyright © 2020 Alfian Losari. All rights reserved.
//

import Foundation

enum CoronaAPIError: Error {
    case invalidURL
    case invalidSerialization
    case badHTTPResponse
    case error(NSError)
    case noData
}

protocol CoronaRepositoryService {
    func getTotalCount(for status: CoronaStatusType, completion: @escaping (Result<Int, CoronaAPIError>) -> ())
    func getAllTotalCount(completion: @escaping (Result<CoronaTotalCount, CoronaAPIError>) -> ())
    func getCases(completion: @escaping (Result<[CoronaCase], CoronaAPIError>) -> ())
}

class CoronaArcGISService: CoronaRepositoryService {

    static let shared = CoronaArcGISService()
    
    private let baseAPIURL = "https://services1.arcgis.com/0MSEUqKaxRlEPj5g/arcgis/rest/services/ncov_cases/FeatureServer/1/query"
    private let urlSession = URLSession.shared
    private let jsonDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .millisecondsSince1970
        return decoder
    }()
        
    private init() {}
    
    func getTotalCount(for status: CoronaStatusType, completion: @escaping (Result<Int, CoronaAPIError>) -> ()) {
        guard let url = generateURL(with: generateURLQueryItems(where: status.totalCountWhereQuery, outStatistics: status.outStatisticForSumQuery, cacheHint: true)) else {
            completion(.failure(.invalidURL))
            return
        }
        
        
        executeDataTaskAndDecode(with: url) { (result: Result<CoronaTotalCountResponse, CoronaAPIError>) in
            switch result {
            case .success(let response):
                guard let totalCount = response.features.first?.attributes.value else {
                    completion(.failure(.noData))
                    return
                }
                completion(.success(totalCount))
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getAllTotalCount(completion: @escaping (Result<CoronaTotalCount, CoronaAPIError>) -> ()) {        
        var confirmedResult: Result<Int, CoronaAPIError>?
        var deathResult: Result<Int, CoronaAPIError>?
        var recoveredResult: Result<Int, CoronaAPIError>?
        
        let dispatchGroup = DispatchGroup()
        
        dispatchGroup.enter()
        getTotalCount(for: .confirmed) { result in
            confirmedResult = result
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        getTotalCount(for: .death) { result in
            deathResult = result
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        getTotalCount(for: .recovered) { result in
            recoveredResult = result
            dispatchGroup.leave()
        }
        
        dispatchGroup.notify(queue: DispatchQueue.global(qos: .userInitiated)) {
            guard
                let confirmed = confirmedResult,  case let .success(confirmedCount) = confirmed,
                let recovered = recoveredResult, case let .success(recoveredCount) = recovered,
                let death = deathResult, case let .success(deathCount) = death else {
                completion(.failure(.noData))
                return
            }
            completion(.success(CoronaTotalCount(confirmed: confirmedCount, death: deathCount, recovered: recoveredCount)))
        }
    }
    
    func getCases(completion: @escaping (Result<[CoronaCase], CoronaAPIError>) -> ()) {
        guard let url = generateURL(with: generateURLQueryItems(where: CoronaStatusType.caseWhereQuery, orderByFields: CoronaStatusType.caseOrderByFieldsQuery, resultOffset: 0, resultRecordCount: 500, cacheHint: true)) else {
            completion(.failure(.invalidURL))
            return
        }
        print(url.absoluteString)

        
        executeDataTaskAndDecode(with: url) { (result: Result<CoronaCaseResponse, CoronaAPIError>) in
            switch result {
            case .success(let response):
                completion(.success(response.features.map { $0.attributes }))
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    private func generateURLQueryItems(format: String = "json", where: String, returnGeometry: Bool = false, spatialRel: String = "esriSpatialRelIntersects", outFields: String = "*", outStatistics: String? = nil, orderByFields: String? = nil, resultOffset: Int? = nil, resultRecordCount: Int? = nil, cacheHint: Bool? = nil) -> [URLQueryItem] {
        var items = [
            URLQueryItem(name: "f", value: format),
            URLQueryItem(name: "where", value: `where`),
            URLQueryItem(name: "returnGeometry", value: String(returnGeometry)),
            URLQueryItem(name: "spatialRef", value: spatialRel),
            URLQueryItem(name: "outFields", value: "*"),
        ]
        
        if let outStatistics = outStatistics {
            items.append(URLQueryItem(name: "outStatistics", value: outStatistics))
        }
        
        if let orderByFields = orderByFields {
            items.append(URLQueryItem(name: "orderByFields", value: orderByFields))
        }
        
        if let resultOffset = resultOffset {
            items.append(URLQueryItem(name: "resultOffset", value: String(resultOffset)))
        }
        
        if let resultRecordCount = resultRecordCount {
            items.append(URLQueryItem(name: "resultRecordCount", value: String(resultRecordCount)))
        }
        
        if let cacheHint = cacheHint {
            items.append(URLQueryItem(name: "cacheHint", value: String(cacheHint)))
        }
        return items
    }
    
    private func generateURL(with queryItems: [URLQueryItem]) -> URL? {
        guard var urlComponents = URLComponents(string: baseAPIURL) else {
            return nil
        }
        urlComponents.queryItems = queryItems
        return urlComponents.url
    }
    
    private func executeDataTaskAndDecode<D: Decodable>(with url: URL, completion: @escaping (Result<D, CoronaAPIError>) -> ()) {
        urlSession.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(.error(error as NSError)))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode >= 200 && httpResponse.statusCode < 300 else {
                completion(.failure(.badHTTPResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            do {
                let model = try self.jsonDecoder.decode(D.self, from: data)
                completion(.success(model))
            } catch {
                completion(.failure(.invalidSerialization))
            }
        }.resume()
    }

}
