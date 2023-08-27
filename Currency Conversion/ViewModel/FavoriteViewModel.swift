//
//  FavoriteviewModel.swift
//  Currency Conversion
//
//  Created by Yasser Mohamed on 26/08/2023.
//

import Foundation
import UIKit

class FavoriteViewModel {
    var coreDataService = CoreDataService()

    func updateFavoriteList(cell:FavouriteCollectionViewCell, favoriteCurrencies:[FavoriteList], indexPath: IndexPath ) {
        if cell.favoriteButton.status == true  {
            if favoriteCurrencies.isEmpty{
                coreDataService.addItem(currecnyName: CurrencyList.countries[indexPath.item], currencyCode: CurrencyList.threeCode[indexPath.item], currencyFlag: CurrencyList.flags[indexPath.item])
                print("FirstItem")
                
                 
            }
            else {
                for fav in favoriteCurrencies {
                    if CurrencyList.countries[indexPath.item] != fav.currencyName {
                        coreDataService.addItem(currecnyName: CurrencyList.countries[indexPath.item], currencyCode: CurrencyList.threeCode[indexPath.item], currencyFlag: CurrencyList.flags[indexPath.item])
                        
                        print("added")
                        break
                    }
                }
            }
        }
   
        else if cell.favoriteButton.status == false {
            for fav in favoriteCurrencies {
                if CurrencyList.countries[indexPath.item] == fav.currencyName {
                    coreDataService.deleteItem(item: fav)
                    print("deleted")
                }
            }
        }
      
    }
}
