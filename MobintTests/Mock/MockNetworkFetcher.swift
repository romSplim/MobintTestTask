//
//  MockNetworkFetcher.swift
//  MobintTests
//
//  Created by ramil on 22.05.2023.
//

import Foundation
@testable import MobintTestTask

class MockNetworkFetcher: NetworkFetcherProtocol {
    
    var fetchCompaniesExecutionCount = 0
    
    func fetchCompanies(endPoint: MobintTestTask.APIManager,
                        completion: @escaping (Result<[MobintTestTask.CompanyCard], MobintTestTask.NetworkError>) -> Void) {
        fetchCompaniesExecutionCount += 1
        let dummy: [CompanyCard] = []
        completion(.success(dummy))
    }
}
