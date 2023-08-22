//
//  CurrencyConversionViewModel.swift
//  Currency Conversion
//
//  Created by Yasser Mohamed on 22/08/2023.
//

import Foundation

class CurrencyConversionViewModel: NSObject {
    private var pairCurrencyService: CurrencyConversionRepoProtocol
     var pairConversion: PairConversion?
    
    init(pairCurrencyService: CurrencyConversionRepoProtocol = CurrencyConversionRepo()) {
        self.pairCurrencyService = pairCurrencyService
    }
    func getConversionResult(amount: String, source: String, target: String,completion: @escaping (String, Error?) -> ()) {
        pairCurrencyService.getConversion(amount: amount, source: source, target: target) {response,error in
            guard let result = response else { return }
            completion(result.conversionResult.description,error)
        }
    }
   
    
     
    
}
