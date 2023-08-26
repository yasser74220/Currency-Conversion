//
//  CurrencyConversionRepo.swift
//  Currency Conversion
//
//  Created by Yasser Mohamed on 22/08/2023.
//

import Foundation
import Alamofire

protocol CurrencyConversionRepoProtocol {
    func getConversion(amount:String, source:String, target:String, completion: @escaping (PairConversion?, Error?) -> () )
    func getCurrencies(completion: @escaping (Currencies?, Error?) -> () )

}

class CurrencyConversionRepo: CurrencyConversionRepoProtocol {
  
    func getCurrencies(completion: @escaping (Currencies?, Error?) -> ()) {
        ApiService.shared.getData(url: Design.EndPoints.Currencies, method: HTTPMethod.get, parameters: [:], encodingType: URLEncoding.default, headers: [:]) { (Response: Currencies?, Error: Error?) in
            if let returnedResponse = Response {
                completion(returnedResponse,nil)
            } else {
                completion(nil,Error)
                print(Error as Any)
            }
        }
    }
    func getConversion(amount: String, source: String, target: String, completion: @escaping (PairConversion?, Error?) -> ()) {
        ApiService.shared.getData(url: "https://v6.exchangerate-api.com/v6/ecf10bab01b34bf0de9636e1/pair/\(source)/\(target)/\(amount)", method: HTTPMethod.get, parameters: [:], encodingType: URLEncoding.default, headers: [:]) { (Response: PairConversion?, Error: Error?) in
            if let returnedResponse = Response {
                completion(returnedResponse,nil)
            } else {
                completion(nil,Error)
                print(Error as Any)
            }
        }
    }
    
 
    
    
}
