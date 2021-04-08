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
            stockSymbol.add(text: stock?.symbol ?? "", font: UIFont(boldWithSize: 18), textColor: .subtitle_label)
            descTextView.text = createDescription(stock: stock!)
        }
    }
    
    //
    // MARK: View Lifecycle
    //
 
    override func viewDidLoad() {
        super.viewDidLoad()
       
        setUpViews()
        navigationController?.setNavigationBarHidden(false, animated: true)

    }

    
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
        label.add(text: "Apple", font: UIFont(boldWithSize: 33), textColor: .main_label)
        label.textAlignment = .left
        label.numberOfLines = 1
        return label
    }()
    
    let stockSymbol: UIButton = {
        let btn = UIButton(type: .system)
        btn.add(text: "APPL", font: UIFont(boldWithSize: 18), textColor: .main_label)
        btn.layer.borderColor = UIColor.subtitle_label.cgColor
        btn.tintColor = .blue
        btn.isEnabled = false
        return btn
    }()
    
    let sectorLabel: UILabel = {
        let label = UILabel()
        label.add(text: "Sector?", font: UIFont(boldWithSize: 20), textColor: .subtitle_label)
        label.textAlignment = .left
        label.numberOfLines = 1
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
        tv.font = UIFont(regularWithSize: 17)
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
        return btn
    }()
    
    lazy var addToWatchlistButton : UIButton = {
        let btn = UIButton(type: .system)
        btn.add(text: "Add", font: UIFont(boldWithSize: 18), textColor: .white)
        btn.layer.borderColor = UIColor.subtitle_label.cgColor
        btn.backgroundColor = .primary_purple
        btn.isEnabled = false
        btn.addTarget(self, action: #selector(handleAddToWatchlist), for: .touchUpInside)
        btn.layer.cornerRadius = 5
        btn.layer.masksToBounds = true
        return btn
    }()
    
    let graphPlaceholderView: UIView = {
        let vw = UIView()
        vw.backgroundColor = .yellow
        return vw
    }()

    func setUpViews() {
        
        view.backgroundColor = .main_background
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: addToWatchlistButton)
        
        let stackView1 = UIStackView(arrangedSubviews: [nameLabel, stockSymbol, sectorLabel])
        stackView1.axis = .horizontal
        stackView1.spacing = 20
    

        view.addSubviews(views: [stackView1, descTextView, graphPlaceholderView, tradeButton])
        
        stackView1.anchor(view.safeAreaLayoutGuide.topAnchor, left: nil, bottom: nil, right: nil, topConstant: 30, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 75)
        stackView1.anchorCenterXToSuperview()
        
        descTextView.anchor(stackView1.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 5, leftConstant: 20, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 175)
        descTextView.anchorCenterXToSuperview()
        
        graphPlaceholderView.anchor(descTextView.bottomAnchor, left: view.leftAnchor, bottom: tradeButton.topAnchor, right: view.rightAnchor, topConstant: 20, leftConstant: 0, bottomConstant: 20, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        tradeButton.anchor(nil, left: nil, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 50, rightConstant: 0, widthConstant: 150, heightConstant: 50)
        tradeButton.anchorCenterXToSuperview()

    }
}










