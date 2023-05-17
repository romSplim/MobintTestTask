//
//  APIError.swift
//  MobintTestTask
//
//  Created by ramil on 09.05.2023.
//

import Foundation

enum NetworkError: Error {
    case decoderError
    case unauthorized
    case badRequest(message: String)
    case serverIssue
    case unknownError

    var message: String {
        switch self {
        case .decoderError:
            return "Ошибка"
        case .unauthorized:
            return "Ошибка авторизации"
        case .badRequest(let message):
            return "\(message)"
        case .serverIssue:
            return "Все упало"
        case .unknownError:
            return "Неизвестная ошибка"
        }
    }
}
