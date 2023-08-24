//
//  firstViewController.swift
//  Currency Conversion
//
//  Created by Yasser Mohamed on 23/08/2023.
//

import UIKit
import iOSDropDown
import SDWebImage
class ConvertViewController: UIViewController {
  
    @IBOutlet weak var toImageView: UIImageView!
    @IBOutlet weak var toStackView: UIStackView!
    @IBOutlet weak var fromStackView: UIStackView!
    @IBOutlet weak var fromImage: UIImageView!
    @IBOutlet weak var sourceDropDownMenu: DropDown!
    @IBOutlet weak var targetDropDownMenu: DropDown!
    @IBOutlet weak var convertButton: UIButton!
    @IBOutlet weak var resultTextField: UITextField!
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var addToFavoritesStackView: UIStackView!
    lazy var viewModel = ConvertViewModel()
    @IBOutlet weak var exchangeRateCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        amountTextField.layer.borderWidth = 0.5
        amountTextField.layer.cornerRadius = 20
        amountTextField.layer.borderColor = UIColor(red: 197/255.0, green: 197/255.0, blue: 197/255.0, alpha: 1.0).cgColor
        resultTextField.layer.cornerRadius = 20
        resultTextField.layer.borderWidth = 0.5
        resultTextField.layer.borderColor = UIColor(red: 197/255.0, green: 197/255.0, blue: 197/255.0, alpha: 1.0).cgColor
        convertButton.layer.cornerRadius = 25
        fromStackView.layer.borderWidth = 0.5
        fromStackView.layer.cornerRadius = 20
        fromStackView.layoutMargins = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
        fromStackView.layer.borderColor = UIColor(red: 197/255.0, green: 197/255.0, blue: 197/255.0, alpha: 1.0).cgColor
        fromStackView.isLayoutMarginsRelativeArrangement = true
        toStackView.layer.borderWidth = 0.5
        toStackView.layer.cornerRadius = 20
        toStackView.layoutMargins = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
        toStackView.layer.borderColor = UIColor(red: 197/255.0, green: 197/255.0, blue: 197/255.0, alpha: 1.0).cgColor
        toStackView.isLayoutMarginsRelativeArrangement = true
        addToFavoritesStackView.layer.borderWidth = 0.5
        addToFavoritesStackView.layer.cornerRadius = 20
        addToFavoritesStackView.layoutMargins = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        addToFavoritesStackView.layer.borderColor = UIColor.black.cgColor
        addToFavoritesStackView.isLayoutMarginsRelativeArrangement = true
        viewModel.getCurrencies() { threeCode,countries, error in
                    self.sourceDropDownMenu.optionArray = countries
                    self.targetDropDownMenu.optionArray = countries
                    self.sourceDropDownMenu.text = countries[0]
                    self.targetDropDownMenu.text = countries[1]
                    self.sourceDropDownMenu.optionImageArray = ["https://cdn.britannica.com/33/4833-004-828A9A84/Flag-United-States-of-America.jpg"]
                    self.fromImage.sd_setImage(with: URL(string: "https://cdn.britannica.com/33/4833-004-828A9A84/Flag-United-States-of-America.jpg"), placeholderImage: UIImage(named: "noArtNES"))
                    self.toImageView.sd_setImage(with: URL(string: "https://cdn.britannica.com/33/4833-004-828A9A84/Flag-United-States-of-America.jpg"), placeholderImage: UIImage(named: "noArtNES"))
                }
        exchangeRateCollectionView.register(UINib(nibName: "ExchangeRateCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ExchangeRateCollectionViewCell")
        exchangeRateCollectionView.register(UINib(nibName: "ExchangeRateHeaderCollectionReusableView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "ExchangeRateHeaderCollectionReusableView")
        exchangeRateCollectionView.dataSource = self
        exchangeRateCollectionView.delegate = self
     
       
        // Do any additional setup after loading the view.
    }

    @IBAction func convertButtonTapped(_ sender: Any) {
                guard let source = sourceDropDownMenu.text, let target = targetDropDownMenu.text, let amount = amountTextField.text else { return }
             
                 self.viewModel.getConversionResult(amount: amount, source: source, target: target, completion: { value, error in
                    DispatchQueue.main.async {
                        self.resultTextField.text = value
                    }
                })
        
    }

}


extension ConvertViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.frame.width, height: 65)
       
    }

   
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ExchangeRateCollectionViewCell", for: indexPath) as! ExchangeRateCollectionViewCell
        cell.setCellData(name: "United States Dollar", value: "1.4", image: "https://cdn.britannica.com/33/4833-004-828A9A84/Flag-United-States-of-America.jpg")
     
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
        
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "ExchangeRateHeaderCollectionReusableView", for: indexPath) as! ExchangeRateHeaderCollectionReusableView
        return header
    }

}
