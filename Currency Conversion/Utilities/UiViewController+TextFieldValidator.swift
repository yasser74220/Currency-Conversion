//
//  UiViewController+TextFieldValidator.swift
//  Currency Conversion
//
//  Created by Yasser Mohamed on 27/08/2023.
//

import Foundation
import UIKit
import Lottie

extension UIViewController {
    @objc func validator ( textField:UITextField){
          let rgx = NSPredicate(format:"SELF MATCHES %@", "[+-]?([0-9]*[.])?[0-9]+")
         var animationView: LottieAnimationView?

          if (rgx.evaluate(with: textField.text)){
              animationView = .init(name: "valid")
              animationView?.frame =  textField.frame.offsetBy(dx: textField.frame.width / 2 + 10, dy: textField.frame.height / 2 + 25)
              animationView?.loopMode = .playOnce
              view.addSubview(animationView!)
              animationView?.reloadImages()
              animationView?.play { (finished) in
                  animationView!.isHidden = true
              }
              
          }
          else {
              animationView = .init(name: "invalid")
              animationView?.frame =  textField.frame.offsetBy(dx: textField.frame.width / 2 + 10, dy: textField.frame.height / 2 + 25)
              animationView?.loopMode = .repeat(2)
              view.addSubview(animationView!)
              animationView?.reloadImages()
              animationView?.play { (finished) in
                  animationView!.isHidden = true
              }
          }
      }
}
