//
//  FavoriteViewController.swift
//  Currency Conversion
//
//  Created by Yasser Mohamed on 24/08/2023.
//

import UIKit

class FavoriteViewController: UIViewController {
    let context = { UIApplication.shared.delegate as! AppDelegate }().persistentContainer.viewContext
    lazy var viewModel = ConvertViewModel()
    var favoriteCurrencies = [FavoriteList]()
    @IBOutlet var favoriteCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        favoriteCollectionView.delegate = self
        favoriteCollectionView.dataSource = self
        favoriteCollectionView.register(UINib(nibName: "FavouriteCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "FavouriteCollectionViewCell")
        favoriteCollectionView.register(UINib(nibName: "ExchangeRateHeaderCollectionReusableView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "ExchangeRateHeaderCollectionReusableView")
        getItems()
        // Do any additional setup after loading the view.
    }

    func getItems() {
        viewModel.getCurrencies { threecode, countries, flags,_  in
              
                self.favoriteCollectionView.reloadData()
            }
            favoriteCurrencies = Design.Functions.getItems(collectionView: favoriteCollectionView)
    }

}
 
extension FavoriteViewController {
    func addItem(currecnyName: String, currencyCode: String, currencyFlag: String) {
        let newItem = FavoriteList(context: context)
        newItem.currencyCode = currencyCode
        newItem.currencyName = currecnyName
        newItem.createdAt = Date()
        newItem.currencyFlagUrl = currencyFlag
        do {
            try context.save()
        } catch {
        }
    }

    func deleteItem(item: FavoriteList) {
        context.delete(item)
        do {
            try context.save()
        } catch {
        }
    }
}

extension FavoriteViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        CurrencyList.countries.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FavouriteCollectionViewCell", for: indexPath) as! FavouriteCollectionViewCell
        cell.setCellData(name: CurrencyList.threeCode[indexPath.item], value: CurrencyList.countries[indexPath.item], image: CurrencyList.flags[indexPath.item],buttonTag: indexPath.item)
        for fav in favoriteCurrencies {
            if CurrencyList.countries[indexPath.item] == fav.currencyName {
                 cell.favoriteButton.setStatus(true)
                
            }
            
        }
        cell.btnTapAction = { [self]
           () in
            if cell.favoriteButton.status == true  {
                if favoriteCurrencies.isEmpty{
                    addItem(currecnyName: CurrencyList.countries[indexPath.item], currencyCode: CurrencyList.threeCode[indexPath.item], currencyFlag: CurrencyList.flags[indexPath.item])
                    print("FirstItem")
                    
                    favoriteCurrencies = try! Design.Shared.persistentContainerContext.fetch(FavoriteList.fetchRequest())
                }
                else {
                    for fav in favoriteCurrencies {
                        if CurrencyList.countries[indexPath.item] != fav.currencyName {
                            addItem(currecnyName: CurrencyList.countries[indexPath.item], currencyCode: CurrencyList.threeCode[indexPath.item], currencyFlag: CurrencyList.flags[indexPath.item])
                            
                            print("added")
                            break
                        }
                    }
                }
            }
       
            else if cell.favoriteButton.status == false {
                for fav in favoriteCurrencies {
                    if CurrencyList.countries[indexPath.item] == fav.currencyName {
                        deleteItem(item: fav)
                        print("deleted")
                    }
                }
            }
          
            
        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "ExchangeRateHeaderCollectionReusableView", for: indexPath) as! ExchangeRateHeaderCollectionReusableView
        header.label.text = "My Favorites"
        return header
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 65)
    }

 
}
