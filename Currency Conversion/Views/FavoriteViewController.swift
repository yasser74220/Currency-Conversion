//
//  FavoriteViewController.swift
//  Currency Conversion
//
//  Created by Yasser Mohamed on 24/08/2023.
//

import UIKit

class FavoriteViewController: UIViewController {
    let context = { UIApplication.shared.delegate as! AppDelegate }().persistentContainer.viewContext
    // all currencies
    lazy var viewModel = ConvertViewModel()
    var currencies: [String] = []
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
        do {
            viewModel.getCurrencies { _, countries, _ in
                self.currencies = countries
                self.favoriteCollectionView.reloadData()
            }
            favoriteCurrencies = try context.fetch(FavoriteList.fetchRequest())
            DispatchQueue.main.async {
                self.favoriteCollectionView.reloadData()
            }
        } catch {
        }
    }

    /*
     // MARK: - Navigation

     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         // Get the new view controller using segue.destination.
         // Pass the selected object to the new view controller.
     }
     */
}

extension FavoriteViewController {
    func addItem(currecnyName: String, currencyCode: String) {
        let newItem = FavoriteList(context: context)
        newItem.currencyCode = currencyCode
        newItem.currencyName = currecnyName
        newItem.createdAt = Date()
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
        currencies.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FavouriteCollectionViewCell", for: indexPath) as! FavouriteCollectionViewCell
        cell.setCellData(name: currencies[indexPath.row], value: currencies[indexPath.row], image: "https://cdn.britannica.com/33/4833-004-828A9A84/Flag-United-States-of-America.jpg")
        for fav in favoriteCurrencies {
            if currencies[indexPath.row] == fav.currencyName {
                cell.favoriteButton.setStatus(true)
            }
            
        }
        
        cell.btnTapAction = {
           () in
             cell.favoriteButton.update()
             print( cell.favoriteButton.status)
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

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! FavouriteCollectionViewCell
         
    }
}
