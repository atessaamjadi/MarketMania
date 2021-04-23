//
//  StockDetailVC.swift
//  MarketMania
//
//  Created by Thor Larson on 4/8/21.
//

import UIKit

class StockDetailVC: UIViewController {
    
    var stock: Stock? {
        didSet {
            nameLabel.text = stock?.companyName
            stockSymbol.add(text: stock?.symbol ?? "", font: UIFont(boldWithSize: 16), textColor: .subtitle_label)
            descTextView.text = createDescription(stock: stock!)
        }
    }
    
    //
    // MARK: View Lifecycle
    //
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // button shit
        
        tradeButton.addTarget(self, action: #selector(test), for: .touchDown)
        
        buyButton = UIButton(type: .custom)
        buyButton.frame = CGRect(x: 0, y:0, width: 70, height: 70)
        buyButton.center.x = view.center.x
        buyButton.center.y = view.frame.maxY * 0.93
        buyButton.layer.cornerRadius = 0.5
        buyButton.clipsToBounds = true
        buyButton.setImage(UIImage(systemName: "plus.circle.fill"), for: .normal)
        buyButton.contentVerticalAlignment = .fill
        buyButton.contentHorizontalAlignment = .fill
        buyButton.addTarget(self, action: #selector(buyFunc), for: .touchDown)
        buyButton.alpha = 0
        buyButton.tintColor = .primary_purple
        
        buyButtonLabel = UILabel(frame: CGRect(x: 0, y:0, width: 70, height: 70))
        buyButtonLabel.add(text: "Buy Stock", font: UIFont(boldWithSize: 16), textColor: .primary_purple)
        buyButtonLabel.center = CGPoint(x: (self.view.center.x * 0.8), y: (self.view.frame.maxY * 0.85) - 40)
        buyButtonLabel.alpha = 0

        sellButton = UIButton(type: .custom)
        sellButton.frame = CGRect(x: 0, y:0, width: 70, height: 70)
        sellButton.center.x = view.center.x
        sellButton.center.y = view.frame.maxY * 0.93
        sellButton.layer.cornerRadius = 0.5
        sellButton.clipsToBounds = true
        sellButton.setImage(UIImage(systemName: "minus.circle.fill"), for: .normal)
        sellButton.contentVerticalAlignment = .fill
        sellButton.contentHorizontalAlignment = .fill
        sellButton.addTarget(self, action: #selector(sellFunc), for: .touchDown)
        sellButton.alpha = 0
        sellButton.tintColor = .primary_purple
        
        sellButtonLabel = UILabel(frame: CGRect(x: 0, y:0, width: 70, height: 70))
        sellButtonLabel.add(text: "Sell Stock", font: UIFont(boldWithSize: 16), textColor: .primary_purple)
        sellButtonLabel.center = CGPoint(x: (self.view.center.x * 1.2), y: (self.view.frame.maxY * 0.85) - 40)
        sellButtonLabel.alpha = 0
        
        self.view.addSubview(buyButton)
        self.view.addSubview(buyButtonLabel)
        self.view.addSubview(sellButton)
        self.view.addSubview(sellButtonLabel)
        //self.view.addSubview(button)
       
        setUpViews()
        navigationController?.setNavigationBarHidden(false, animated: true)

    }
    
    @objc func buyFunc(sender: UIButton){
        //TODO
        
        let selectAmountVC = TradeSelectAmountVC()
        selectAmountVC.symbol = (stock?.symbol)!
        self.present(UINavigationController(rootViewController: selectAmountVC), animated: true, completion: nil)
        
    }
    
    @objc func sellFunc(sender: UIButton){
        let selectAmountVC = TradeSelectAmountVC()
        selectAmountVC.symbol = (stock?.symbol)!
        selectAmountVC.buying = false
        self.present(UINavigationController(rootViewController: selectAmountVC), animated: true, completion: nil)
    }
        
    @objc func test(sender: UIButton){
        if(toggle){
            //sender.setImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
            toggle = false
            //expand buttons
            UIView.animate(withDuration: 0.3, animations: {
                self.buyButton.alpha = 1
                self.sellButton.alpha = 1
                self.buyButton.center = CGPoint(x: (self.view.center.x * 0.8), y: (self.view.frame.maxY * 0.75))
                self.sellButton.center = CGPoint(x: (self.view.center.x * 1.2), y: (self.view.frame.maxY * 0.75))
                self.buyButtonLabel.alpha = 1
                self.sellButtonLabel.alpha = 1
            })
        }else{
            //sender.setImage(UIImage(systemName: "dollarsign.circle.fill"), for: .normal)
            toggle = true
            //collapse buttons
            UIView.animate(withDuration: 0.3, animations: {
                self.buyButton.alpha = 0
                self.sellButton.alpha = 0
                self.buyButton.center = CGPoint(x: (self.view.center.x), y: (self.view.frame.maxY * 0.93))
                self.sellButton.center = CGPoint(x: (self.view.center.x), y: (self.view.frame.maxY * 0.93))
                self.buyButtonLabel.alpha = 0
                self.sellButtonLabel.alpha = 0
            })
        }
    }
    
    var buyButton : UIButton!
    var sellButton : UIButton!
    
    var buyButtonLabel : UILabel!
    var sellButtonLabel : UILabel!
    
    var buyCenter : CGPoint!
    var sellCenter : CGPoint!
    
    var toggle = true


    
    //
    // MARK: Functions
    //
    
    @objc func handleDismiss() {
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @objc func handleTrade() {
        
        
    }
    
    @objc func handleAddToWatchlist() {
        
        
    }
    
    func createDescription(stock: Stock) -> String {
        var description = ""
        description += "Latest Price: \(stock.latestPrice ?? 0)\n"
        description += "52-Week High: \(stock.week52High ?? 0)\n"
        description += "52-Week Low: \(stock.week52Low ?? 0)\n"
        description += "Average Total Volume: \(stock.avgTotalVolume ?? 0)\n"
        description += "Market Cap: \(stock.marketCap ?? 0)\n"
        description += "Percent Change: \(stock.changePercent ?? 0)\n"
        return description
    }
    
    //
    // MARK: UI Setup
    //
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.add(text: "Apple", font: UIFont(boldWithSize: 30), textColor: .main_label)
        label.textAlignment = .left
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.accessibilityIdentifier = "nl"
        return label
    }()
    
    let stockSymbol: UIButton = {
        let btn = UIButton(type: .system)
        btn.add(text: "APPL", font: UIFont(boldWithSize: 8), textColor: .main_label)
        btn.layer.borderColor = UIColor.subtitle_label.cgColor
        btn.tintColor = .blue
        btn.isEnabled = false
        btn.accessibilityIdentifier = "ss"
        return btn
    }()
    
    let sectorLabel: UILabel = {
        let label = UILabel()
        label.add(text: "Sector?", font: UIFont(boldWithSize: 15), textColor: .subtitle_label)
        label.textAlignment = .center
        label.numberOfLines = 1
        label.accessibilityIdentifier = "sl"
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    let descTextView: UITextView = {
        let tv = UITextView()
        tv.text = "Description\nDescription"
        tv.isScrollEnabled = false
        tv.isEditable = false
        tv.backgroundColor = .clear
        tv.textColor = .main_label
        tv.textAlignment = .left
        tv.font = UIFont(regularWithSize: 15)
        tv.accessibilityIdentifier = "tv"
        return tv
    }()
    
    let tradeButton : UIButton = {
        let btn = UIButton(type: .system)
        btn.add(text: "TRADE", font: UIFont(boldWithSize: 18), textColor: .main_label)
        btn.layer.borderColor = UIColor.subtitle_label.cgColor
        btn.backgroundColor = .primary_purple
        btn.addTarget(self, action: #selector(handleTrade), for: .touchUpInside)
        btn.layer.cornerRadius = 7
        btn.layer.masksToBounds = true
        btn.accessibilityIdentifier = "tb"
        return btn
    }()
    
//    lazy var addToWatchlistButton : UIButton = {
//        let btn = UIButton(type: .system)
//        btn.add(text: "Add", font: UIFont(boldWithSize: 18), textColor: .white)
//        btn.layer.borderColor = UIColor.subtitle_label.cgColor
//        btn.backgroundColor = .primary_purple
//        btn.isEnabled = false
//        btn.addTarget(self, action: #selector(handleAddToWatchlist), for: .touchUpInside)
//        btn.layer.cornerRadius = 5
//        btn.layer.masksToBounds = true
//        btn.accessibilityIdentifier = "atwl"
//        return btn
//    }()
    
    let graphPlaceholderView: UIView = {
        let vw = UIView()
        //vw.backgroundColor = .yellow
        return vw
    }()

    func setUpViews() {
        
        view.backgroundColor = .main_background
        
        //navigationItem.rightBarButtonItem = UIBarButtonItem(customView: addToWatchlistButton)
        
        let stackView1 = UIStackView(arrangedSubviews: [nameLabel]) // todo - add sectorlabel if we get it working
        stackView1.axis = .horizontal
        stackView1.spacing = 20
    

        view.addSubviews(views: [stackView1, stockSymbol, descTextView, tradeButton])
        
        stackView1.anchor(view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 50, leftConstant: 10, bottomConstant: 0, rightConstant: 30, widthConstant: 70, heightConstant: 75)
        stackView1.anchorCenterXToSuperview()
        
        stockSymbol.anchor(stackView1.bottomAnchor, left: view.leftAnchor, bottom: nil, right: nil, topConstant: 0, leftConstant: 15, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        descTextView.anchor(stockSymbol.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 5, leftConstant: 20, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 175)
        descTextView.anchorCenterXToSuperview()
        
//        graphPlaceholderView.anchor(descTextView.bottomAnchor, left: view.leftAnchor, bottom: tradeButton.topAnchor, right: view.rightAnchor, topConstant: 20, leftConstant: 0, bottomConstant: 20, rightConstant: 0, widthConstant: 0, heightConstant: 0)
//        
        tradeButton.anchor(nil, left: nil, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 50, rightConstant: 0, widthConstant: 150, heightConstant: 50)
        tradeButton.anchorCenterXToSuperview()

    }
}










