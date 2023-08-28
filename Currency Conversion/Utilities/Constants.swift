//
//  Constants.swift
//  Currency Conversion
//
//  Created by Yasser Mohamed on 25/08/2023.
//

import Foundation
import UIKit
import Lottie

struct Design {
    struct Colors {
        static let lightGrey = UIColor(red: 197 / 255.0, green: 197 / 255.0, blue: 197 / 255.0, alpha: 1.0).cgColor
    }
    struct Measurments {
        static let borderWidth: CGFloat = 0.5
        static let cornerRaduis: CGFloat = 20.0
    }
    struct Shared {
        static let persistentContainerContext = { UIApplication.shared.delegate as! AppDelegate }().persistentContainer.viewContext
    }
     
    struct Functions {
        static func emptyListLottie (collectionView: UICollectionView, view: UIView) {
            var animationView: LottieAnimationView?
            animationView = .init(name: "emptyList")
            animationView?.frame = collectionView.frame
            animationView?.loopMode = .playOnce
            view.addSubview(animationView!)
            animationView?.play{_ in
                animationView?.isHidden = true
            }
            
        }
        static func getItems(collectionView: UICollectionView) -> [FavoriteList] {
            do {
                let data = try Design.Shared.persistentContainerContext.fetch(FavoriteList.fetchRequest())
                DispatchQueue.main.async {
                    collectionView.reloadData()
                }
                return data
            }
            catch {

            }
            return []
        }
    }
    struct EndPoints {
        static let Currencies = "https://mocki.io/v1/58d53648-9753-4e03-894f-30e0ba0395c1"
    }
}

struct CurrencyList {
    static var favoriteList = try! Design.Shared.persistentContainerContext.fetch(FavoriteList.fetchRequest())
    static var threeCode:[String] = []
    static var countries:[String] = []
    static var flags:[String] = []
}
