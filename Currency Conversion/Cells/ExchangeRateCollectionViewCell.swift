//
//  ExchangeRateCollectionViewCell.swift
//  Currency Conversion
//
//  Created by Yasser Mohamed on 23/08/2023.
//

import UIKit
import SDWebImage
class ExchangeRateCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var exchangeRateLabel: UILabel!
    @IBOutlet weak var currencyName: UILabel!
    @IBOutlet weak var currencyFlagImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        currencyFlagImage.layer.cornerRadius = 25
        // Initialization code
    }
    
    func setCellData (name:String, value:String, image:String){
        exchangeRateLabel.text = value
        currencyName.text = name
        currencyFlagImage.sd_setImage(with: URL(string: image))
    }

}
