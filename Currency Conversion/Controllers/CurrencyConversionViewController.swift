//
//  CurrencyConversionViewController.swift
//  Currency Conversion
//
//  Created by Yasser Mohamed on 21/08/2023.
//

import UIKit
import Alamofire

class CurrencyConversionViewController: UIViewController, UITextFieldDelegate {



    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var sourceTextField: UITextField!
    @IBOutlet weak var targetTextField: UITextField!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var validLabel: UILabel!
    var currencies = ["EUR", "NZD", "GBP"]
    var sourcePickerView = UIPickerView()
    var targetPickerView = UIPickerView()
    override func viewDidLoad() {
        super.viewDidLoad()
        sourceTextField.inputView = sourcePickerView
        targetTextField.inputView = targetPickerView
        sourcePickerView.delegate = self
        sourcePickerView.dataSource = self
        targetPickerView.delegate = self
        targetPickerView.dataSource = self
        amountTextField.addTarget(self, action: #selector(validator(textField: )), for: .editingChanged)
        amountTextField.addTarget(self, action: #selector(fetch(textField: )), for: .allEditingEvents)
          // Do any additional setup af ter loading the view.
    }
    @objc func validator ( textField:UITextField){
        let rgx = NSPredicate(format:"SELF MATCHES %@", "[+-]?([0-9]*[.])?[0-9]+")
         
        if (rgx.evaluate(with: textField.text)){
            validLabel.layer.isHidden = true
        }
        else {
            validLabel.layer.isHidden = false

        }
    }
    @objc func fetch (textField:UITextField){
        fetchCurrency()
    }
    
    @IBAction func convertButtonTapped(_ sender: UIButton) {
        fetchCurrency()
        print("tappp")
    }
    func fetchCurrency() {
        ApiService.shared.getData(url: "https://v6.exchangerate-api.com/v6/ecf10bab01b34bf0de9636e1/pair/\(sourceTextField.text ?? "")/\(targetTextField.text ?? "")/\(amountTextField.text ?? "")", method: HTTPMethod.get, parameters: [:], encodingType: URLEncoding.default, headers: [:]) { (Response: PairConversion?, Error: Error?) in
            if let returnedResponse = Response {
                print(returnedResponse.result)
                DispatchQueue.main.async {
                    self.valueLabel.text = String(returnedResponse.conversionResult)

                }
            }
            else {
                print(Error as Any)
            }
        }
    }
}

extension CurrencyConversionViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {

        switch pickerView {
        case sourcePickerView:
            return currencies.count
        case targetPickerView:
            return currencies.count
        default:
            return 1
        }


    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView {
        case sourcePickerView:
            return currencies[row]
        case targetPickerView:
            return currencies[row]
        default:
            return ""
        }


    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView {
        case sourcePickerView:
            sourceTextField.text = currencies[row]
            sourceTextField.resignFirstResponder()
        case targetPickerView:
            targetTextField.text = currencies[row]
            targetPickerView.resignFirstResponder()
        default: break

        }
    }
}
