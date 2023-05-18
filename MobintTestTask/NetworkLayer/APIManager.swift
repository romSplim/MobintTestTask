//
//  APIManager.swift
//  MobintTestTask
//
//  Created by ramil on 09.05.2023.
//

import Foundation

typealias HTTPHeaders = [String: String]

enum APIManager {
    case getAllCompanies(offset: Int)
    case getAllCompaniesIdeal(offset: Int)
    case getAllCompaniesLong(offset: Int)
    case getAllCompaniesError(offset: Int)
    
    private var baseUrl: String {
        return "http://dev.bonusmoney.pro/mobileapp"
    }
    
    private var path: String {
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
    
    private var url: URL {
        guard let url = URL(string: baseUrl + path) else {
        preconditionFailure("Invalid URL")}
        return url
    }
    
    private var method: HTTPMethod {
        switch self {
        case .getAllCompanies,
                .getAllCompaniesIdeal,
                .getAllCompaniesLong,
                .getAllCompaniesError:
            return .post
        }
    }
    
    private var httpBody: Data? {
        switch self {
        case .getAllCompanies(let offset),
                .getAllCompaniesIdeal(let offset),
                .getAllCompaniesLong(let offset),
                .getAllCompaniesError(let offset):
            
            let body: [String: Any] = ["offset": offset]
            let bodyData = try? JSONSerialization.data(withJSONObject: body)
            return bodyData
        }
    }
    
    private var headers: HTTPHeaders {
        return ["TOKEN": "123"]
    }
    
    func request() -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = headers
        request.httpBody = httpBody
        return request
    }
}
