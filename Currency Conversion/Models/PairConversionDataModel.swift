//
//  PairConversionDataModel.swift
//  Currency Conversion
//
//  Created by Yasser Mohamed on 22/08/2023.
//

import Foundation

// MARK: - PairConversion
struct PairConversion: Codable {
    let baseCode, targetCode, amount, conversionRate: String

    enum CodingKeys: String, CodingKey {
        case baseCode = "base_code"
        case targetCode = "target_code"
        case amount
        case conversionRate = "conversion_rate"
    }
}
