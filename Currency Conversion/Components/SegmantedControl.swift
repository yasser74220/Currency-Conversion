//
//  SegmantedControl.swift
//  Currency Conversion
//
//  Created by Yasser Mohamed on 28/08/2023.
//

import Foundation
import UIKit
class SegmentedControl : UISegmentedControl {
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = frame.height / 2
         layer.borderWidth = 0.5
       
         layer.borderColor = UIColor.gray.cgColor
         layer.masksToBounds = true
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    func setupViews() {
         self.selectedSegmentIndex = 0
 
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }
    
}
