//
//  CurrenciesDataModel.swift
//  Currency Conversion
//
//  Created by Yasser Mohamed on 23/08/2023.
//

import Foundation

// MARK: - Currecncies
struct Currencies: Codable {
    let result: String
    let documentation, termsOfUse: String
    let supportedCodes: [[String]]

    enum CodingKeys: String, CodingKey {
        case result, documentation
        case termsOfUse = "terms_of_use"
        case supportedCodes = "supported_codes"
    }
}
