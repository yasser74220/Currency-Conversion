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
    lazy var viewModel = ConvertViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        amountTextField.layer.borderWidth = Design.Measurments.borderWidth
        amountTextField.layer.cornerRadius = Design.Measurments.cornerRaduis
        amountTextField.layer.borderColor = Design.Colors.lightGrey
        firstTargetResultTextField.layer.borderWidth = Design.Measurments.borderWidth
        firstTargetResultTextField.layer.cornerRadius = Design.Measurments.cornerRaduis
        firstTargetResultTextField.layer.borderColor = Design.Colors.lightGrey
        secondTargetResultTextField.layer.borderWidth = Design.Measurments.borderWidth
        secondTargetResultTextField.layer.cornerRadius = Design.Measurments.cornerRaduis
        secondTargetResultTextField.layer.borderColor = Design.Colors.lightGrey
        CompareButton.layer.cornerRadius = Design.Measurments.cornerRaduis
        sourceDropDownMenu.optionArray = viewModel.getOpthioArrayForDropDown()
        firstTargetDropDownMenu.optionArray = viewModel.getOpthioArrayForDropDown()
        secondTargetDropDownMenu.optionArray = viewModel.getOpthioArrayForDropDown()
        sourceDropDownMenu.text = viewModel.getOpthioArrayForDropDown()[0]
        firstTargetDropDownMenu.text = viewModel.getOpthioArrayForDropDown()[1]
        secondTargetDropDownMenu.text = viewModel.getOpthioArrayForDropDown()[2]
        sourceDropDownMenu.selectedIndex = 0
        firstTargetDropDownMenu.selectedIndex = 1
        secondTargetDropDownMenu.selectedIndex = 2
        amountTextField.addTarget(self, action: #selector(validator(textField:)), for: .editingDidEnd)
    }
  
    @IBAction func compareButtonTapped(_ sender: Any) {
    }
    
}
