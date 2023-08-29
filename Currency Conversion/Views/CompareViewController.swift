//
//  secondViewController.swift
//  Currency Conversion
//
//  Created by Yasser Mohamed on 23/08/2023.
//

import UIKit
import iOSDropDown
import Lottie
class CompareViewController: UIViewController {
    //MARK: - Outlets
    @IBOutlet weak var secondTargetResultTextField: UITextField!
    @IBOutlet weak var firstTargetResultTextField: UITextField!
    @IBOutlet weak var secondTargetDropDownMenu: DropDown!
    @IBOutlet weak var firstTargetDropDownMenu: DropDown!
    @IBOutlet weak var sourceDropDownMenu: DropDown!
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var CompareButton: UIButton!
    //MARK: - Variables
    lazy var viewModel = ConvertViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialUI()
        amountTextField.addTarget(self, action: #selector(validator(textField:)), for: .editingDidEnd)
    }
  
    @IBAction func compareButtonTapped(_ sender: Any) {
        handleCompareButton()
    }
    
}

//MARK: - Extensions
extension CompareViewController {
    func initialUI() {
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
    }
    func handleCompareButton() {
         
            var animationView: LottieAnimationView?
            animationView = .init(name: "loading")
            animationView?.frame = CompareButton.frame
            animationView?.backgroundColor = .white
            animationView?.loopMode = .playOnce
            view.addSubview(animationView!)
            animationView?.play{ [self] finish in
                animationView?.isHidden = true

                if ((amountTextField.text!.isEmpty)) {
                    validator(textField: amountTextField)

                }
                else {
                    guard let source = sourceDropDownMenu.selectedIndex, let target1 = firstTargetDropDownMenu.selectedIndex,let target2 = secondTargetDropDownMenu.selectedIndex else { return }
                    viewModel.getConversionResultForCompare(amount: amountTextField.text!, source: CurrencyList.threeCode[source], target1: CurrencyList.threeCode[target1], target2: CurrencyList.threeCode[target2], completion:  { value,error in
                       
                        DispatchQueue.main.async { [self] in
                            self.firstTargetResultTextField.text = value.0
                            self.secondTargetResultTextField.text = value.1
                    
                        }
                    })

                }
            }
 
    }
}

