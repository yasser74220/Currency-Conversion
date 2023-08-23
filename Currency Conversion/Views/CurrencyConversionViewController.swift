//
//  CurrencyConversionViewController.swift
//  Currency Conversion
//
//  Created by Yasser Mohamed on 21/08/2023.
//

import Alamofire
import iOSDropDown
import UIKit
class CurrencyConversionViewController: UIViewController {
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var amountTextField: UITextField!
    @IBOutlet weak var sourceDropDown: DropDown!
    @IBOutlet weak var targetDropDown: DropDown!
    @IBOutlet weak var converterView: UIView!
    var codes:[String] = []
    lazy var viewModel = CurrencyConversionViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        amountTextField.layer.cornerRadius = 10
        converterView.layer.cornerRadius = 16
        converterView.layer.shadowColor = UIColor.black.cgColor
        converterView.layer.shadowOpacity = 0.6
        converterView.layer.shadowOffset = .zero
        converterView.layer.shadowRadius = 1
        viewModel.getCurrencies() { threeCode,countries, error in
            self.sourceDropDown.optionArray = countries
            self.targetDropDown.optionArray = countries
            self.sourceDropDown.text = countries[0]
            self.targetDropDown.text = countries[1]
            self.codes = threeCode
        }
        
    }
 
    @IBAction func convertButtonTapped(_ sender: UIButton) {
        guard let source = sourceDropDown.selectedIndex, let target = targetDropDown.selectedIndex, let amount = amountTextField.text else { return }
        let s = codes[source]
        let t = codes[target]
         self.viewModel.getConversionResult(amount: amount, source: s, target: t, completion: { value, error in
            DispatchQueue.main.async {
                sender.titleLabel?.text = value
            }
        })


    }
}
 

