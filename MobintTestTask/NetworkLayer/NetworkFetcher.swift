//
//  NetworkFetcher.swift
//  MobintTestTask
//
//  Created by ramil on 09.05.2023.
//

import Foundation

protocol NetworkFetcherProtocol {
    func fetchCompanies(endPoint: APIManager, completion: @escaping (Result<[CompanyCard], NetworkError>) -> Void)
}

final class NetworkFetcher: NetworkFetcherProtocol {
    
    static let shared = NetworkFetcher()
    //MARK: - Private init
    private init() {}
    
    //MARK: - Methods
    func fetchCompanies(endPoint: APIManager, completion: @escaping (Result<[CompanyCard], NetworkError>) -> Void) {
        let request = endPoint.request()
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let response = response as? HTTPURLResponse {
                self.handleResponse(response: response, data: data, completion: completion)
            }
        }.resume()
    }
    
    //MARK: - Private methods
    private func handleResponse(response: HTTPURLResponse, data: Data?, completion: (Result<[CompanyCard], NetworkError>) -> Void) {
        switch response.statusCode {
        case 200..<300:
            guard let data,
                  let companiesJson = try? decodeJSON(type: [CompanyCard].self, from: data) else {
                completion(.failure(.decoderError))
                return
            }
            completion(.success(companiesJson))
        case 400:
            guard let data,
                  let errorJson = try? decodeJSON(type: ErrorModel.self,
                                                  from: data) else {
                completion(.failure(.decoderError))
                return
            }
            let message = errorJson.message
            completion(.failure(.badRequest(message: message)))
        case 401:
            completion(.failure(.unauthorized))
        case 500:
            completion(.failure(.serverIssue))
        default:
            completion(.failure(.unknownError))
        }
    }
        
    private func decodeJSON<T: Decodable>(type: T.Type, from data: Data) throws -> T? {
        do {
            let decoder = JSONDecoder()
            let jsonData = try decoder.decode(type, from: data)
            return jsonData
        } catch {
            return nil
        }
    }
}
