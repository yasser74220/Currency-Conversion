//
//  ExchangeRateHeaderCollectionReusableView.swift
//  Currency Conversion
//
//  Created by Yasser Mohamed on 23/08/2023.
//

import UIKit

class ExchangeRateHeaderCollectionReusableView: UICollectionReusableView {
    @IBOutlet weak var label: UILabel!
    var btnTapAction : (()->())?

    @IBOutlet weak var closeButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
      
        // Initialization code
    }
  
    
    @IBAction func closeButtonTapped(_ sender: UIButton) {
        btnTapAction?()
    }
}
