//
//  Model.swift
//  MobintTestTask
//
//  Created by ramil on 09.05.2023.
//

import Foundation

// MARK: - CompanyCard
struct CompanyCard: Decodable {
    let company: Company
    let customerMarkParameters: CustomerMarkParameters
    let mobileAppDashboard: MobileAppDashboard
}

// MARK: - Company
struct Company: Decodable {
    let companyID: String

    enum CodingKeys: String, CodingKey {
        case companyID = "companyId"
    }
}

// MARK: - CustomerMarkParameters
struct CustomerMarkParameters: Decodable {
    let loyaltyLevel: LoyaltyLevel
    let mark: Int
}

// MARK: - LoyaltyLevel
struct LoyaltyLevel: Decodable {
    let number: Int
    let name: String
    let requiredSum, markToCash, cashToMark: Int
}

// MARK: - MobileAppDashboard
struct MobileAppDashboard: Decodable {
    let companyName: String
    let logo: String
    let backgroundColor, mainColor, cardBackgroundColor, textColor: String
    let highlightTextColor, accentColor: String
}
