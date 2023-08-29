//
//  getCurrenciesEndPoint.swift
//  Currency ConversionTests
//
//  Created by Yasser Mohamed on 29/08/2023.
//

import XCTest
@testable import Currency_Conversion
@testable import Alamofire
final class getCurrenciesEndPoint: XCTestCase {
    var requstParams = [String: Any]()
    var promise:XCTestExpectation!
    var serverResponseValue:Int = 0
    var serverResponseData:AnyObject?
        override class func setUp() {
        super.setUp()
 
    }
    override class func tearDown() {
         super.tearDown()
    }
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        var dollarToEyptionPoundValue: String = ""
        var dollarToSaudiRiyalValue: String = ""
        ApiService.shared.getData(url: "https://compare-test-production.up.railway.app/pair/USD/EGP/2", method: HTTPMethod.get, parameters: [:], encodingType: URLEncoding.default, headers: [:]) { (Response: PairConversion?, Error: Error?) in
            if let returnedResponse = Response {
                dollarToEyptionPoundValue = returnedResponse.conversionRate
            } else {
                XCTFail("errorTestMessage \(String(describing: Error?.localizedDescription ))")
            }
            
        }
        ApiService.shared.getData(url: "https://compare-test-production.up.railway.app/pair/USD/SAR/2", method: HTTPMethod.get, parameters: [:], encodingType: URLEncoding.default, headers: [:]) { (Response: PairConversion?, Error: Error?) in
            if let returnedResponse = Response {
                dollarToSaudiRiyalValue = returnedResponse.conversionRate
            } else {
                XCTFail("errorTestMessage \(String(describing: Error?.localizedDescription))")
            }
            
        }
        XCTAssertGreaterThanOrEqual(dollarToEyptionPoundValue, dollarToSaudiRiyalValue)
        XCTAssertTrue(true)
        
    }

     

}
