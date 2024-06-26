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
    func getExchange(amount:String,Favorites:String,source:String,completion: @escaping (ExchangeDataModel?, Error?) -> () )
    func getCompare(amount: String, source: String, target1: String, target2: String, completion: @escaping (CompareConversion?, Error?) -> () )
    func getCurrencies(completion: @escaping (Currencies?, Error?) -> () )

}

class CurrencyConversionRepo: CurrencyConversionRepoProtocol {
    func getExchange(amount: String, Favorites: String,source:String, completion: @escaping (ExchangeDataModel?, Error?) -> ()) {
        ApiService.shared.getData(url: "https://finalv99compare-production.up.railway.app/compare/\(source)/\(Favorites)/\(amount)", method: HTTPMethod.get, parameters: [:], encodingType: URLEncoding.default, headers: [:]) { (Response: ExchangeDataModel?, Error: Error?) in
            if let returnedResponse = Response {
                print(returnedResponse)
                completion(returnedResponse,nil)
            } else {
                completion(nil,Error)
                print(Error as Any)
            }
        }
    }
    
    func getCompare(amount: String, source: String, target1: String, target2: String,  completion: @escaping (CompareConversion?, Error?) -> ()) {
        ApiService.shared.getData(url: Design.EndPoints.Compare+"/\(source)/\(target1)/\(target2)/\(amount)", method: HTTPMethod.get, parameters: [:], encodingType: URLEncoding.default, headers: [:]) { (Response: CompareConversion?, Error: Error?) in
            if let returnedResponse = Response {
                completion(returnedResponse,nil)
            } else {
                completion(nil,Error)
                print(Error as Any)
            }
        }
    }
    
  
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
        ApiService.shared.getData(url: Design.EndPoints.Pair+"/\(source)/\(target)/\(amount)", method: HTTPMethod.get, parameters: [:], encodingType: URLEncoding.default, headers: [:]) { (Response: PairConversion?, Error: Error?) in
            if let returnedResponse = Response {
                print(returnedResponse)
                completion(returnedResponse,nil)
            } else {
                completion(nil,Error)
                print(Error as Any)
            }
        }
    }
  
    
 
    
    
}
