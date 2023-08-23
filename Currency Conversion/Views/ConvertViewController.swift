//
//  firstViewController.swift
//  Currency Conversion
//
//  Created by Yasser Mohamed on 23/08/2023.
//

import UIKit
import iOSDropDown
class ConvertViewController: UIViewController {
    @IBOutlet weak var sourceDropDownMenu: DropDown!
    @IBOutlet weak var targetDropDownMenu: DropDown!
    @IBOutlet weak var convertButton: UIButton!
    @IBOutlet weak var resultTextField: UITextField!
    @IBOutlet weak var amountTextField: UITextField!
    lazy var viewModel = ConvertViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        resultTextField.layer.cornerRadius = 10
        amountTextField.layer.cornerRadius = 10
        convertButton.layer.cornerRadius = 25
                viewModel.getCurrencies() { threeCode,countries, error in
                    self.sourceDropDownMenu.optionArray = countries
                    self.targetDropDownMenu.optionArray = countries
                    self.sourceDropDownMenu.text = countries[0]
                    self.targetDropDownMenu.text = countries[1]
                    
                }
        // Do any additional setup after loading the view.
    }

    @IBAction func convertButtonTapped(_ sender: Any) {
                guard let source = sourceDropDownMenu.text, let target = targetDropDownMenu.text, let amount = amountTextField.text else { return }
             
                 self.viewModel.getConversionResult(amount: amount, source: source, target: target, completion: { value, error in
                    DispatchQueue.main.async {
                        self.resultTextField.text = value
                    }
                })
        
    }
    

}
