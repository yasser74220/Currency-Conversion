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
       
        CompareButton.layer.cornerRadius = 25
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        firstTargetResultTextField.layer.cornerRadius = 10
        secondTargetResultTextField.layer.cornerRadius = 10
        amountTextField.layer.cornerRadius = 10
    }

}
