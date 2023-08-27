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
    @IBOutlet weak var sourceDropDownMenu: DropDown!
    @IBOutlet weak var targetDropDownMenu: DropDown!
    @IBOutlet weak var convertButton: UIButton!
    @IBOutlet weak var resultTextField: UITextField!
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var addToFavoritesStackView: UIStackView!
    @IBOutlet weak var exchangeRateCollectionView: UICollectionView!
    
    lazy var viewModel = ConvertViewModel()
    var favoriteCurrencies = [FavoriteList]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialUI()
     
        viewModel.getCurrencies() {[self] threeCode,countries,flags,_   in
            sourceDropDownMenu.optionArray = viewModel.getOpthioArrayForDropDown()
           targetDropDownMenu.optionArray = viewModel.getOpthioArrayForDropDown()
            sourceDropDownMenu.text = viewModel.getOpthioArrayForDropDown()[0]
            targetDropDownMenu.text = viewModel.getOpthioArrayForDropDown()[1]
            sourceDropDownMenu.selectedIndex = 0
            targetDropDownMenu.selectedIndex = 1
            }
        
        exchangeRateCollectionView.register(UINib(nibName: "ExchangeRateCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ExchangeRateCollectionViewCell")
        exchangeRateCollectionView.register(UINib(nibName: "ExchangeRateHeaderCollectionReusableView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "ExchangeRateHeaderCollectionReusableView")
        exchangeRateCollectionView.dataSource = self
        exchangeRateCollectionView.delegate = self
        addToFavoritesStackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(goToFavorites(_:))))
        amountTextField.addTarget(self, action: #selector(validator), for: .allEvents)
        favoriteCurrencies = Design.Functions.getItems(collectionView: exchangeRateCollectionView)
      
    }
    @objc func validator ( textField:UITextField){
          let rgx = NSPredicate(format:"SELF MATCHES %@", "[+-]?([0-9]*[.])?[0-9]+")
         var animationView: LottieAnimationView?

          if (rgx.evaluate(with: textField.text)){
              animationView = .init(name: "valid")
              animationView?.frame =  textField.frame.offsetBy(dx: 65, dy: 50)
              animationView?.loopMode = .playOnce
              view.addSubview(animationView!)
              animationView?.reloadImages()
              animationView?.play { (finished) in
                  animationView!.isHidden = true
              }
              
          }
          else {
              animationView = .init(name: "invalid")
              animationView?.frame =  textField.frame.offsetBy(dx: 65, dy: 50)
              animationView?.loopMode = .repeat(2)
              view.addSubview(animationView!)
              animationView?.reloadImages()
              animationView?.play { (finished) in
                  animationView!.isHidden = true
              }
          }
      }
    override func viewDidAppear(_ animated: Bool) {
        DispatchQueue.main.async { [self] in
            favoriteCurrencies = Design.Functions.getItems(collectionView: exchangeRateCollectionView)
        }
    }
   
    @IBAction func convertButtonTapped(_ sender: UIButton) {
                guard let source = sourceDropDownMenu.selectedIndex, let target = targetDropDownMenu.selectedIndex, let amount = amountTextField.text else { return }
                
        self.viewModel.getConversionResult(amount: amount, source: CurrencyList.threeCode[source], target: CurrencyList.threeCode[target], completion: { value, error in
            
                    DispatchQueue.main.async {
                       
                        self.resultTextField.text = value
                    }
                })
        
    }

}


extension ConvertViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if favoriteCurrencies.count == 0 {
            Design.Functions.emptyListLottie(collectionView: collectionView, view: view)
            return favoriteCurrencies.count
        } else {
            return favoriteCurrencies.count

        }
         
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.frame.width, height: 65)
       
    }

   
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ExchangeRateCollectionViewCell", for: indexPath) as! ExchangeRateCollectionViewCell
        cell.setCellData(name: favoriteCurrencies[indexPath.row].currencyName!, value: favoriteCurrencies[indexPath.row].currencyCode!, image: favoriteCurrencies[indexPath.row].currencyFlagUrl! ,code: favoriteCurrencies[indexPath.row].currencyName!)
       
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
extension ConvertViewController{
    func initialUI()  {
        amountTextField.layer.borderWidth = Design.Measurments.borderWidth
        amountTextField.layer.cornerRadius = Design.Measurments.cornerRaduis
        amountTextField.layer.borderColor = Design.Colors.lightGrey
        resultTextField.layer.cornerRadius = Design.Measurments.cornerRaduis
        resultTextField.layer.borderWidth = Design.Measurments.borderWidth
        resultTextField.layer.borderColor = Design.Colors.lightGrey
        sourceDropDownMenu.layer.borderColor = Design.Colors.lightGrey
        targetDropDownMenu.layer.borderColor = Design.Colors.lightGrey
        sourceDropDownMenu.layer.cornerRadius = Design.Measurments.cornerRaduis
        sourceDropDownMenu.layer.borderWidth = Design.Measurments.borderWidth
        targetDropDownMenu.layer.cornerRadius = Design.Measurments.cornerRaduis
        targetDropDownMenu.layer.borderWidth = Design.Measurments.borderWidth
        convertButton.layer.cornerRadius = Design.Measurments.cornerRaduis
        addToFavoritesStackView.layer.borderWidth = Design.Measurments.borderWidth
        addToFavoritesStackView.layer.cornerRadius = Design.Measurments.cornerRaduis
        addToFavoritesStackView.layoutMargins = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        addToFavoritesStackView.layer.borderColor = UIColor.black.cgColor
        addToFavoritesStackView.isLayoutMarginsRelativeArrangement = true
    }
}
