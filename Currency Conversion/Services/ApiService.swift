//
//  ApiService.swift
//  Currency Conversion
//
//  Created by Yasser Mohamed on 20/08/2023.
//

import Foundation
import Alamofire

class ApiService {
    static let shared = ApiService()

    func getData <T:Codable> (url: String, method: HTTPMethod, parameters: [String: Any]?, encodingType: ParameterEncoding, headers: HTTPHeaders?, completion: @escaping (T?, Error?) -> ()) {

        AF.request(url, method: method, parameters: parameters, encoding: encodingType, headers: headers).responseDecodable(of: T.self) { response in
            switch response.result {
            case .success(let res):
                print(res)
                completion(res, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
}
