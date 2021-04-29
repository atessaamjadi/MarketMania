//
//  PortfolioDetailVC.swift
//  MarketMania
//
//  Created by Atessa Amjadi on 4/19/21.
//

import UIKit

class PortfolioDetailVC: UIViewController  {
    
    var portfolio: PortfolioStock? {
        //property observer that changes everytime 'portfolio' is updated
        didSet {
            portfolioSymbol.add(text: portfolio?.symbol ?? "TEMP", font: UIFont(boldWithSize: 33), textColor: .main_label)
            descTextView.text = createDescription(portfolio: portfolio!)
        }
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
        
        setUpViews()
    }
    
    func createDescription(portfolio: PortfolioStock) -> String {
        var description = ""
        description += "Shares:  \(portfolio.shares ?? 0)\n"
        description += "Average price:  $\(portfolio.avgPrice ?? 0)\n"
        description += "Percent gain:  \(String(format: "%.2f",portfolio.percentGain ?? 0))%\n"
        return description
        
    }
    
    @objc func buyFunc(sender: UIButton){
        //TODO
        
        let selectAmountVC = TradeSelectAmountVC()
        selectAmountVC.symbol = portfolioSymbol.text!
        self.present(UINavigationController(rootViewController: selectAmountVC), animated: true, completion: nil)
        
    }
    
    @objc func sellFunc(sender: UIButton){
        let selectAmountVC = TradeSelectAmountVC()
        selectAmountVC.symbol = portfolioSymbol.text!
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
    // MARK: UI Setup
    //
 
    let portfolioSymbol: UILabel = {
        let ps = UILabel()
        ps.add(text: "Apple", font: UIFont(boldWithSize: 43), textColor: .main_label)
        ps.textAlignment = .center
        ps.numberOfLines = 1
        return ps
    }()
   
    let descTextView: UITextView = {
        let desc = UITextView()
        desc.text = "Description\nDescription"
        desc.isScrollEnabled = false
        desc.isEditable = false
        desc.backgroundColor = .clear
        desc.textColor = .main_label
        desc.textAlignment = .center
        desc.font = UIFont(regularWithSize: 20)
        return desc
    }()
    
    let tradeButton : UIButton = {
        let btn = UIButton(type: .system)
        btn.add(text: "TRADE", font: UIFont(boldWithSize: 18), textColor: .main_label)
        btn.layer.borderColor = UIColor.subtitle_label.cgColor
        btn.backgroundColor = .primary_purple
        btn.layer.cornerRadius = 7
        btn.layer.masksToBounds = true
        btn.accessibilityIdentifier = "tb"
        return btn
    }()
    
    
    func setUpViews(){
        
        view.backgroundColor = .main_background
        
        view.addSubviews(views: [portfolioSymbol, descTextView, tradeButton])
        
        portfolioSymbol.anchor(view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: view.frame.size.height/4, leftConstant: 10, bottomConstant: 0, rightConstant: 10, widthConstant: 0, heightConstant: 0)
        
        descTextView.anchor(portfolioSymbol.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 30, leftConstant: 10, bottomConstant: 0, rightConstant: 10, widthConstant: 0, heightConstant: 0)
     
        tradeButton.anchor(nil, left: nil, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 50, rightConstant: 0, widthConstant: 150, heightConstant: 50)
        tradeButton.anchorCenterXToSuperview()
        
    }
    
   
}
