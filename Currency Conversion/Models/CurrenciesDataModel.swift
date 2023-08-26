//
//  CurrenciesDataModel.swift
//  Currency Conversion
//
//  Created by Yasser Mohamed on 23/08/2023.
//

import Foundation

// MARK: - Currencies
struct Currencies: Codable {
    let currencies: [Currency]
}

// MARK: - Currency
struct Currency: Codable {
    let code, name: String
    let flagURL: String

    enum CodingKeys: String, CodingKey {
        case code, name
        case flagURL = "flag_url"
    }
}
