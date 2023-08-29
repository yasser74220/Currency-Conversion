//
//  ExchangeDataModel.swift
//  Currency Conversion
//
//  Created by Yasser Mohamed on 29/08/2023.
//

import Foundation
struct ExchangeDataModelElement: Codable {
    let baseCode, targetCode, amount, conversionRate: String

    enum CodingKeys: String, CodingKey {
        case baseCode = "base_code"
        case targetCode = "target_code"
        case amount
        case conversionRate = "conversion_rate"
    }
}

typealias ExchangeDataModel = [ExchangeDataModelElement]
