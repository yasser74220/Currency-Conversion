////
////  CurrencyRepo.swift
////  Currency Conversion
////
////  Created by Yasser Mohamed on 26/08/2023.
////
//
//import Foundation
//func getCurrencies(completion: @escaping (_ threeCode:[String],_ countries:[String],_ flags:[String], Error?) -> ()) {
//    CurrenciesService.getCurrencies {response,error in
//        guard let result = response else { return }
//
//        var threeCode:[String] = []
//        var countries:[String] = []
//        var flags:[String] = []
//        for currency in result.currencies {
//            threeCode.append(currency.code)
//            countries.append(currency.name)
//            flags.append(currency.flagURL)
//
//        }
//        completion(threeCode,countries,flags,nil)
//
//    }
//}
//func getConversionResult(amount: String, source: String, target: String,completion: @escaping (String, Error?) -> ()) {
//    pairCurrencyService.getConversion(amount: amount, source: source, target: target) {response,error in
//        guard let result = response else { return }
//        completion(result.conversionResult.description,error)
//    }
//}
//func fillDropDown(completion: @escaping (_ optionArray:[String]) -> ()) {
//    var optionArray = [String]()
//    for flag in CurrencyList.threeCode {
//        optionArray.append(getFlagEmoji(flag: flag) + "  " + flag)
//       }
//     completion(optionArray)
//   }
//
//   func getFlagEmoji(flag: String) -> String{
//       let code = flag.dropLast()
//       let base: UInt32 = 127397
//       var emoji = ""
//       for scalar in code.unicodeScalars {
//           emoji.append(String(UnicodeScalar(base + scalar.value)!))
//
//       }
//
//       return emoji
//   }
