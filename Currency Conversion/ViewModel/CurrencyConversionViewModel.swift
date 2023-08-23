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
   
    func getCurrencies(completion: @escaping (_ threeCode:[String],_ Countries:[String], Error?) -> ()) {
        pairCurrencyService.getCurrencies {response,error in
            guard let result = response else { return }
            var threeCode:[String] = []
            var countries:[String] = []
            for currency in result.supportedCodes {
                threeCode.append(currency[0])
                countries.append(currency[0]+" - "+currency[1])
            }
            completion(threeCode,countries,nil)
 
        }
    }
     
    
    
}
