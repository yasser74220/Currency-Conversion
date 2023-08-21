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
        let firstController = ViewController()
        let secondController = ViewController()
        let thirdController = ViewController()
        let viewControllers = [firstController, secondController, thirdController]
        self.setViewControllers(viewControllers, animated: true)
        guard let tabBarItems = self.tabBar.items else { return }
        let unSelectedTabImages = ["arrowshape.right", "heart", "chart.line.uptrend.xyaxis.circle"]
        let selectedTabImages = ["arrowshape.right.fill", "heart.fill", "chart.line.uptrend.xyaxis.circle"]
        for x in 0...2 {
            tabBarItems[x].image = UIImage(systemName: unSelectedTabImages[x])
            tabBarItems[x].selectedImage = UIImage(systemName: selectedTabImages[x])
        }
        self.tabBar.backgroundColor = .white
        self.tabBar.tintColor = .green
    }
}
