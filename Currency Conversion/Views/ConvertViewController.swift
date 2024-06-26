//
//  firstViewController.swift
//  Currency Conversion
//
//  Created by Yasser Mohamed on 23/08/2023.
//

import iOSDropDown
import Lottie
import SDWebImage
import UIKit

class ConvertViewController: UIViewController {
    //MARK: - OUTLETS
    @IBOutlet var sourceDropDownMenu: DropDown!
    @IBOutlet var targetDropDownMenu: DropDown!
    @IBOutlet var convertButton: UIButton!
    @IBOutlet var resultTextField: UITextField!
    @IBOutlet var amountTextField: UITextField!
    @IBOutlet var addToFavoritesStackView: UIStackView!
    @IBOutlet var exchangeRateCollectionView: UICollectionView!
    //MARK: - Variables
    lazy var viewModel = ConvertViewModel()
    var favoriteCurrencies = [FavoriteList]()
    var favoriteCurrenciesExchange: [String] = ["1","1","1","1","1","1","1","1","1","1","1","1","1"]
    
    //MARK: - ViewDidload
    override func viewDidLoad() {
        super.viewDidLoad()
        initialUI()
        
        // Fetch Currencies and fill dropdown menu with it
        viewModel.getCurrencies { [self] _, _, _, _ in
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
        
        amountTextField.addTarget(self, action: #selector(validator), for: .editingDidEnd)
        NotificationCenter.default.addObserver(self, selector: #selector(methodOfReceivedNotification(notification:)), name: Notification.Name("FavoritesList"), object: nil)
        
        favoriteCurrencies = Design.Functions.getItems(collectionView: exchangeRateCollectionView)
    }
    @objc func methodOfReceivedNotification(notification: Notification) {
         favoriteCurrenciesExchange =  ["1","1","1","1","1","1","1","1","1","1","1","1","1"]

        handleExchangeForFavorite()
        favoriteCurrencies = Design.Functions.getItems(collectionView: exchangeRateCollectionView)

    }

   
    
    @IBAction func convertButtonTapped(_ sender: UIButton) {
        handleExchangeForFavorite()
        handlingConverButton()
 
    }
    
}

extension ConvertViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if favoriteCurrencies.count == 0 {
            Design.Functions.emptyListLottie(collectionView: collectionView, view: view)
            
            return 0
        } else {
            return favoriteCurrencies.count
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 65)
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ExchangeRateCollectionViewCell", for: indexPath) as! ExchangeRateCollectionViewCell
        cell.setCellData(name: favoriteCurrencies[indexPath.row].currencyCode!, value: favoriteCurrenciesExchange[indexPath.row] , image: favoriteCurrencies[indexPath.row].currencyFlagUrl!, code: favoriteCurrencies[indexPath.row].currencyName!)
      
        return cell
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "ExchangeRateHeaderCollectionReusableView", for: indexPath) as! ExchangeRateHeaderCollectionReusableView
        header.label.text = "My Portofolio"
        header.closeButton.isHidden = true
      
        return header
    }
}

extension ConvertViewController {
    func initialUI() {
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
    func handlingConverButton() {
        var animationView: LottieAnimationView?
        animationView = .init(name: "loading")
        animationView?.frame = convertButton.frame
        animationView?.backgroundColor = .white
        animationView?.loopMode = .playOnce
        view.addSubview(animationView!)
        animationView?.play{ [self] finish in
            animationView?.isHidden = true

            if ((amountTextField.text!.isEmpty)) {
                validator(textField: amountTextField)

            }
            else {
                guard let source = sourceDropDownMenu.selectedIndex, let target = targetDropDownMenu.selectedIndex else { return }
                viewModel.getConversionResult(amount: amountTextField.text!, source: CurrencyList.threeCode[source], target: CurrencyList.threeCode[target], completion: { value, error in
                   
                    DispatchQueue.main.async { [self] in
                        self.resultTextField.text = value
                        exchangeRateCollectionView.reloadData()

                    }
                })

            }
        }
    }
    func handleExchangeForFavorite(){
        Task{
            var favorite:[String] = []
            for currency in favoriteCurrencies {
                
                favorite.append(currency.currencyCode ?? "")
            }
            var string: String?
              for element in favorite {
                  if string == nil {
                      string = element
                  } else {
                  string = string! + "," + element
                  }
              }
            viewModel.getFavoriteExchangeRate(amount: amountTextField.text ?? "1", favorite: string ?? "",source: CurrencyList.threeCode[sourceDropDownMenu.selectedIndex!]){ [self]response, error in
                favoriteCurrenciesExchange.removeAll()

                for x in response{
                    favoriteCurrenciesExchange.append(x.conversionRate)
                    
                }
               print(favoriteCurrenciesExchange)
                
            }
            DispatchQueue.main.async { [self] in
                
                exchangeRateCollectionView.reloadData()

            }
        }
    }
}
