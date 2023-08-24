//
//  FavoriteViewController.swift
//  Currency Conversion
//
//  Created by Yasser Mohamed on 24/08/2023.
//

import UIKit

class FavoriteViewController: UIViewController {

    @IBOutlet weak var favoriteCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        favoriteCollectionView.delegate = self
        favoriteCollectionView.dataSource = self
        favoriteCollectionView.register(UINib(nibName: "FavouriteCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "FavouriteCollectionViewCell")
        favoriteCollectionView.register(UINib(nibName: "ExchangeRateHeaderCollectionReusableView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "ExchangeRateHeaderCollectionReusableView")
        // Do any additional setup after loading the view.
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

extension FavoriteViewController: UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        15
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FavouriteCollectionViewCell", for: indexPath) as! FavouriteCollectionViewCell
        cell.setCellData(name: "United States Dollar", value: "Dollar", image: "https://cdn.britannica.com/33/4833-004-828A9A84/Flag-United-States-of-America.jpg")
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
