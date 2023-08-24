//
//  secondViewController.swift
//  Currency Conversion
//
//  Created by Yasser Mohamed on 23/08/2023.
//

import UIKit
import iOSDropDown
class CompareViewController: UIViewController {

    @IBOutlet weak var secondTargetResultTextField: UITextField!
    @IBOutlet weak var firstTargetResultTextField: UITextField!
    @IBOutlet weak var secondTargetDropDownMenu: DropDown!
    @IBOutlet weak var firstTargetDropDownMenu: DropDown!
    @IBOutlet weak var sourceDropDownMenu: DropDown!
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var CompareButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        amountTextField.layer.borderWidth = 0.5
        amountTextField.layer.cornerRadius = 20
        amountTextField.layer.borderColor = UIColor(red: 197/255.0, green: 197/255.0, blue: 197/255.0, alpha: 1.0).cgColor
        amountTextField.borderStyle = .none

        firstTargetResultTextField.layer.borderWidth = 0.5
        firstTargetResultTextField.layer.cornerRadius = 20
        firstTargetResultTextField.layer.borderColor = UIColor(red: 197/255.0, green: 197/255.0, blue: 197/255.0, alpha: 1.0).cgColor
        firstTargetResultTextField.borderStyle = .none
        
        secondTargetResultTextField.layer.borderWidth = 0.5
        secondTargetResultTextField.layer.cornerRadius = 20
        secondTargetResultTextField.layer.borderColor = UIColor(red: 197/255.0, green: 197/255.0, blue: 197/255.0, alpha: 1.0).cgColor
        secondTargetResultTextField.borderStyle = .none
        sourceDropDownMenu.borderStyle = .none
        firstTargetDropDownMenu.borderStyle = .none
        secondTargetDropDownMenu.borderStyle = .none
     
        CompareButton.layer.cornerRadius = 25
    }
  

}
