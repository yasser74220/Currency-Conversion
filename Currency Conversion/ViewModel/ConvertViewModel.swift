//
//  ConvertViewModel.swift
//  Currency Conversion
//
//  Created by Yasser Mohamed on 23/08/2023.
//

import Foundation

class ConvertViewModel {
    private var pairCurrencyService: CurrencyConversionRepoProtocol
     var pairConversion: PairConversion?
    
    init(pairCurrencyService: CurrencyConversionRepoProtocol = CurrencyConversionRepo()) {
        self.pairCurrencyService = pairCurrencyService
    }
    func getCurrencies(completion: @escaping (_ threeCode:[String],_ countries:[String],_ flags:[String], Error?) -> ()) {
        pairCurrencyService.getCurrencies {response,error in
            guard let result = response else { return }
 
            var threeCode:[String] = []
            var countries:[String] = []
            var flags:[String] = []
            for currency in result.currencies {
                threeCode.append(currency.code)
                countries.append(currency.name)
                flags.append(currency.flagURL)
                
            }
            completion(threeCode,countries,flags,nil)
 
        }
    }
    func getConversionResult(amount: String, source: String, target: String,completion: @escaping (String, Error?) -> ()) {
        pairCurrencyService.getConversion(amount: amount, source: source, target: target) {response,error in
            guard let result = response else { return }
            completion(result.conversionRate.description,error)
        }
    }
    func getConversionResultForCompare(amount: String, source: String, target1: String, target2: String,completion: @escaping ((String,String), Error?) -> ()) {
        pairCurrencyService.getCompare(amount: amount, source: source, target1: target1, target2: target2) {response,error in
            guard let result = response else { return }
            completion((result.conversionRate1.description,result.conversionRate2.description),error)
        }
    }
    func getOpthioArrayForDropDown() -> [String]{
        var optionArray = [String]()
        for flag in CurrencyList.threeCode {
            optionArray.append(getFlagEmoji(flag: flag) + "  " + flag)
           }
         return optionArray
       }
    func getFlagEmoji(flag: String) -> String{
        let code = flag.dropLast()
        let base: UInt32 = 127397
        var emoji = ""
        for scalar in code.unicodeScalars {
            emoji.append(String(UnicodeScalar(base + scalar.value)!))
            
        }
        
        return emoji
    }
   
}
