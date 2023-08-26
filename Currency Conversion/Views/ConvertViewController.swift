//
//  firstViewController.swift
//  Currency Conversion
//
//  Created by Yasser Mohamed on 23/08/2023.
//

import UIKit
import iOSDropDown
import SDWebImage
import Lottie
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
    var models = [FavoriteList]()
    override func viewDidLoad() {
        super.viewDidLoad()
        initialUI()
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
        let tap = UITapGestureRecognizer(target: self, action: #selector(goToFavorites(_:)))
        addToFavoritesStackView.addGestureRecognizer(tap)
        models = Design.Functions.getItems(collectionView: exchangeRateCollectionView)
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
extension ConvertViewController{
    func initialUI()  {
        amountTextField.layer.borderWidth = Design.Measurments.borderWidth
        amountTextField.layer.cornerRadius = Design.Measurments.cornerRaduis
        amountTextField.layer.borderColor = Design.Colors.lightGrey
        resultTextField.layer.cornerRadius = Design.Measurments.cornerRaduis
        resultTextField.layer.borderWidth = Design.Measurments.borderWidth
        resultTextField.layer.borderColor = Design.Colors.lightGrey
        convertButton.layer.cornerRadius = Design.Measurments.cornerRaduis
        fromStackView.layer.borderWidth = Design.Measurments.borderWidth
        fromStackView.layer.cornerRadius = Design.Measurments.cornerRaduis
        fromStackView.layoutMargins = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
        fromStackView.layer.borderColor = Design.Colors.lightGrey
        fromStackView.isLayoutMarginsRelativeArrangement = true
        toStackView.layer.borderWidth = Design.Measurments.borderWidth
        toStackView.layer.cornerRadius = Design.Measurments.cornerRaduis
        toStackView.layoutMargins = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
        toStackView.layer.borderColor = Design.Colors.lightGrey
        toStackView.isLayoutMarginsRelativeArrangement = true
        addToFavoritesStackView.layer.borderWidth = Design.Measurments.borderWidth
        addToFavoritesStackView.layer.cornerRadius = Design.Measurments.cornerRaduis
        addToFavoritesStackView.layoutMargins = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        addToFavoritesStackView.layer.borderColor = UIColor.black.cgColor
        addToFavoritesStackView.isLayoutMarginsRelativeArrangement = true
    }
}

extension ConvertViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if models.count == 0 {
            Design.Functions.emptyListLottie(collectionView: collectionView, view: view)
            return models.count
        }
         
        return models.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.frame.width, height: 65)
       
    }

   
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ExchangeRateCollectionViewCell", for: indexPath) as! ExchangeRateCollectionViewCell
        cell.setCellData(name: models[indexPath.row].currencyName!, value: models[indexPath.row].currencyCode!, image: "https://cdn.britannica.com/33/4833-004-828A9A84/Flag-United-States-of-America.jpg",code:   models[indexPath.row].currencyName!)
       
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
        
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "ExchangeRateHeaderCollectionReusableView", for: indexPath) as! ExchangeRateHeaderCollectionReusableView
        header.label.text = "My Portofolio"
        return header
    }

}
