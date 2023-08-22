//
//  CurrencyConversionViewController.swift
//  Currency Conversion
//
//  Created by Yasser Mohamed on 21/08/2023.
//
import Alamofire
import UIKit
class CurrencyConversionViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet var amountTextField: UITextField!
    @IBOutlet var sourceTextField: UITextField!
    @IBOutlet var targetTextField: UITextField!
    @IBOutlet var valueLabel: UILabel!
    @IBOutlet var validLabel: UILabel!
    var currencies = ["EUR", "NZD", "GBP"]
    var sourcePickerView = UIPickerView()
    var targetPickerView = UIPickerView()
    lazy var viewModel = CurrencyConversionViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        sourceTextField.inputView = sourcePickerView
        targetTextField.inputView = targetPickerView
        sourcePickerView.delegate = self
        sourcePickerView.dataSource = self
        targetPickerView.delegate = self
        targetPickerView.dataSource = self
        amountTextField.addTarget(self, action: #selector(validator(textField:)), for: .editingChanged)
    }

    @IBAction func convertButtonTapped(_ sender: UIButton) {
        guard let source = sourceTextField.text, let target = targetTextField.text, let amount = amountTextField.text else { return }
        self.viewModel.getConversionResult(amount: amount, source: source, target: target,completion: { value,error in
            DispatchQueue.main.async {
                self.valueLabel.text = value
            }
        } )
      
      
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
extension CurrencyConversionViewController {
    @objc func validator(textField: UITextField) {
        let rgx = NSPredicate(format: "SELF MATCHES %@", "[+-]?([0-9]*[.])?[0-9]+")

        if rgx.evaluate(with: textField.text) {
            validLabel.layer.isHidden = true
        } else {
            
            validLabel.layer.isHidden = false
        }
    }
}
