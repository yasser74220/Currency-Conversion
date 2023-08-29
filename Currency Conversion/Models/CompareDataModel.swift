//
//  CompareDataModel.swift
//  Currency Conversion
//
//  Created by Yasser Mohamed on 28/08/2023.
//

import Foundation
 
// MARK: - CompareConversion
struct CompareConversion: Codable {
    let base, firstTarget, secondTarget, amount: String
    let conversionRate1, conversionRate2: String
}
