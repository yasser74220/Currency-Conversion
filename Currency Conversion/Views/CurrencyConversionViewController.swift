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
 
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var contentView: UIView!
    var codes:[String] = []
     override func viewDidLoad() {
        super.viewDidLoad()
         segmentedControl.layer.cornerRadius = 10

         segmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged(_:)), for: .allEvents)
         segmentedControl.selectedSegmentIndex = 0
         displayViewController(ConvertViewController())

    }
  
 
    @objc func segmentedControlValueChanged(_ segmentedControl: UISegmentedControl) {
        let selectedSegmentIndex = segmentedControl.selectedSegmentIndex
        switch selectedSegmentIndex {
        case 0:
            displayViewController(ConvertViewController())
        case 1:
            displayViewController(CompareViewController())
        default:
            displayViewController(ConvertViewController())
        }
    }

    private func displayViewController(_ viewController: UIViewController) {
        addChild(viewController)
        contentView.addSubview(viewController.view)
        viewController.view.frame = contentView.bounds
        viewController.view.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        viewController.didMove(toParent: self)
    }
}
 

