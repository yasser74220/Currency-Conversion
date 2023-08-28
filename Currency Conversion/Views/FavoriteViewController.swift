//
//  FavoriteViewController.swift
//  Currency Conversion
//
//  Created by Yasser Mohamed on 24/08/2023.
//

import UIKit

class FavoriteViewController: UIViewController {
    @IBOutlet var favoriteCollectionView: UICollectionView!

    lazy var viewModel = ConvertViewModel()
    lazy var favoriteViewModel = FavoriteViewModel()
    var favoriteCurrencies = CurrencyList.favoriteList
    var coreDataService = CoreDataService()
    override func viewDidLoad() {
        super.viewDidLoad()
        favoriteCollectionView.delegate = self
        favoriteCollectionView.dataSource = self
        favoriteCollectionView.register(UINib(nibName: "FavouriteCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "FavouriteCollectionViewCell")
        favoriteCollectionView.register(UINib(nibName: "ExchangeRateHeaderCollectionReusableView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "ExchangeRateHeaderCollectionReusableView")
        getItems()
    }
 
    func getItems() {
        viewModel.getCurrencies { threecode, countries, flags, _ in

        }
        favoriteCurrencies = Design.Functions.getItems(collectionView: favoriteCollectionView)
    }

}
 
extension FavoriteViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        CurrencyList.countries.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FavouriteCollectionViewCell", for: indexPath) as! FavouriteCollectionViewCell
        cell.setCellData(name: CurrencyList.threeCode[indexPath.item], value: CurrencyList.countries[indexPath.item], image: CurrencyList.flags[indexPath.item], buttonTag: indexPath.item)
        cell.checkFavorite(favoriteCurrencies: favoriteCurrencies, indexPath: indexPath)
        cell.btnTapAction = { [self]
            () in
            favoriteViewModel.updateFavoriteList(cell: cell, favoriteCurrencies: favoriteCurrencies, indexPath: indexPath)
            favoriteCurrencies = try! Design.Shared.persistentContainerContext.fetch(FavoriteList.fetchRequest())

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
