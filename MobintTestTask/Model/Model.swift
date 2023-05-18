//
//  Model.swift
//  MobintTestTask
//
//  Created by ramil on 09.05.2023.
//

import Foundation

// MARK: - CompanyCard
struct CompanyCard: Codable {
    let company: Company
    let customerMarkParameters: CustomerMarkParameters
    let mobileAppDashboard: MobileAppDashboard
}

// MARK: - Company
struct Company: Codable {
    let companyID: String

    enum CodingKeys: String, CodingKey {
        case companyID = "companyId"
    }
}

// MARK: - CustomerMarkParameters
struct CustomerMarkParameters: Codable {
    let loyaltyLevel: LoyaltyLevel
    let mark: Int
}

// MARK: - LoyaltyLevel
struct LoyaltyLevel: Codable {
    let number: Int
    let name: String
    let requiredSum, markToCash, cashToMark: Int
}

// MARK: - MobileAppDashboard
struct MobileAppDashboard: Codable {
    let companyName: String
    let logo: String
    let backgroundColor, mainColor, cardBackgroundColor, textColor: String
    let highlightTextColor, accentColor: String
}
