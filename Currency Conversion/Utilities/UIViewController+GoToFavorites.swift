//
//  UIViewController+GoToFavorites.swift
//  Currency Conversion
//
//  Created by Yasser Mohamed on 25/08/2023.
//

import Foundation
import UIKit

extension UIViewController {
    @objc func goToFavorites(_ sender: UITapGestureRecognizer? = nil) {
        let vc = FavoriteViewController()
        vc.modalPresentationStyle = .formSheet //change this to your class na
        self.present(vc, animated: true)
    
    }
   
}
