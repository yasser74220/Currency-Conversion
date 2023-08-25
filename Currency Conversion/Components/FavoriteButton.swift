//
//  FavoriteButton.swift
//  Currency Conversion
//
//  Created by Yasser Mohamed on 24/08/2023.
//

import CoreMotion
import UIKit
class FavoriteButton: UIButton {

    var status: Bool = false {
        didSet {
            update()
        }
    }

    var filledIcon = UIImage(systemName: "heart.fill")
    var basicIcon = UIImage(systemName: "heart")
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    func setupViews() {

        self.imageView?.image = basicIcon
        self.setTitle("", for: .normal)
        update()
        self.addTarget(self, action: #selector(toggle), for: .touchUpInside)


    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }

    func update() {
        UIView.transition(with: self, duration: 0.12, options: .transitionCrossDissolve, animations: {
            self.status ? self.setImage(self.filledIcon, for: .normal) : self.setImage(self.basicIcon, for: .normal)
        })
    }

    @objc func toggle() {
        status = !status
    }

    func setStatus(_ status: Bool) {
        self.status = status
    }



}
