//
//  APIManager.swift
//  MobintTestTask
//
//  Created by ramil on 09.05.2023.
//

import Foundation

typealias HTTPHeaders = [String: String]

enum APIManager {
    case getAllCompanies
    case getAllCompaniesIdeal
    case getAllCompaniesLong
    case getAllCompaniesError
    
    private var baseUrl: String {
        return "http://dev.bonusmoney.pro/mobileapp"
    }
    
    var path: String {
        switch self {
        case .getAllCompanies:
            return "/getAllCompanies"
        case .getAllCompaniesIdeal:
            return "/getAllCompaniesIdeal"
        case .getAllCompaniesLong:
            return "/getAllCompaniesLong"
        case .getAllCompaniesError:
            return "/getAllCompaniesError"
        }
    }
    
    var url: URL {
        guard let url = URL(string: baseUrl + path) else {
        preconditionFailure("Invalid URL")}
        return url
    }
    
    var method: HTTPMethod {
        switch self {
        case .getAllCompanies,
                .getAllCompaniesIdeal,
                .getAllCompaniesLong,
                .getAllCompaniesError:
            return .post
        }
    }
    
    func httpBody() -> Data? {
        let body: [String: Any] = ["offset": 2]
        let bodyData = try? JSONSerialization.data(withJSONObject: body)
        return bodyData
    }
    
    var headers: HTTPHeaders {
        return ["TOKEN": "123"]
    }
    
    func request() -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = headers
        request.httpBody = httpBody()
        return request
    }
}
