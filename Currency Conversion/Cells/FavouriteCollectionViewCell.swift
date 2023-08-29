//
//  FavouriteCollectionViewCell.swift
//  Currency Conversion
//
//  Created by Yasser Mohamed on 24/08/2023.
//

import UIKit
import SDWebImage
class FavouriteCollectionViewCell: UICollectionViewCell {
    var btnTapAction : (()->())?

    @IBOutlet weak var favoriteButton: FavoriteButton!
    @IBOutlet weak var currencyCodeLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var currencyimage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
 
        currencyimage.layer.cornerRadius = 25
       
        
    }
    @IBAction func favoriteButtonTapped(_ sender: FavoriteButton) {
        btnTapAction?()

    }
    func checkFavorite(favoriteCurrencies: [FavoriteList],indexPath: IndexPath) {
        print(CurrencyList.countries)
        for fav in favoriteCurrencies {
           if CurrencyList.countries[indexPath.item] == fav.currencyName {
                favoriteButton.setStatus(true)
           }
       }
    }
    func setCellData (name:String, value:String, image:String, buttonTag:Int){
        currencyCodeLabel.text = value
        currencyLabel.text = name
        currencyimage.sd_setImage(with: URL(string: image))
        favoriteButton.tag = buttonTag
    }
}
