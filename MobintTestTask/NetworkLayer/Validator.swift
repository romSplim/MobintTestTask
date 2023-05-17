//
//  Validator.swift
//  MobintTestTask
//
//  Created by ramil on 09.05.2023.
//

import Foundation

class Validator {
    static func validate(response: HTTPURLResponse) throws {
        switch response.statusCode {
        case 400:
            throw NetworkError.badRequest(message: "")
        case 200:
            break
        default:
            throw NetworkError.serverIssue
        }
    }
}
