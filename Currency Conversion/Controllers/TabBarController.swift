//
//  TabBarController.swift
//  Currency Conversion
//
//  Created by Yasser Mohamed on 20/08/2023.
//

import Foundation
import UIKit

class TabBarController: UITabBarController {
    override func viewDidLoad() {
        let firstController = CurrencyConversionViewController()
        let secondController = CurrencyConversionViewController()
        let thirdController = CurrencyConversionViewController()
        let viewControllers = [firstController, secondController, thirdController]
        self.setViewControllers(viewControllers, animated: true)
       

        guard let tabBarItems = self.tabBar.items else { return }
        let unSelectedTabImages = ["coloncurrencysign.circle", "heart.circle", "chart.line.uptrend.xyaxis.circle"]
        let selectedTabImages = ["coloncurrencysign.circle.fill", "heart.circle.fill", "chart.line.uptrend.xyaxis.circle"]
        for x in 0...2 {
            tabBarItems[x].image = UIImage(systemName: unSelectedTabImages[x])
            tabBarItems[x].selectedImage = UIImage(systemName: selectedTabImages[x])
        }
         self.tabBar.backgroundColor = .lightGray.withAlphaComponent(0.2)
        self.tabBar.tintColor = .green.withAlphaComponent(0.8)
    }
}
