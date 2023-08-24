//
//  FavoriteButton.swift
//  Currency Conversion
//
//  Created by Yasser Mohamed on 24/08/2023.
//

import UIKit
import CoreMotion
class FavoriteButton: UIButton {
    
    
    
    var status:Bool = false {
        didSet {
            self.update()
        }
    }
    var filledIcon = UIImage(systemName:"heart.fill")
    var basicIcon = UIImage(systemName:"heart")
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
       
    required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
        }
    func update() {
        UIView.transition(with: self, duration: 0.12, options: .transitionCrossDissolve, animations: {
            self.status ? self.setImage(self.filledIcon, for: .normal) : self.setImage(self.basicIcon, for: .normal)
        })
    }
    func toggle() {
          self.status ? self.setStatus(false) : self.setStatus(true)
      }
      
    func setStatus(_ status: Bool) {
        self.status = status
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
          super.touchesEnded(touches, with: event)
          self.sendHapticFeedback()
          self.toggle()
      }
      
      func sendHapticFeedback() {
          let impactFeedbackgenerator = UIImpactFeedbackGenerator(style: .heavy)
          impactFeedbackgenerator.prepare()
          impactFeedbackgenerator.impactOccurred()
      }
}
