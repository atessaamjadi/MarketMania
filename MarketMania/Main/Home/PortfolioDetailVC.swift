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
        
        setUpViews()
    }
    
    func createDescription(portfolio: PortfolioStock) -> String {
        var description = ""
        description += "Shares:  $\(portfolio.shares ?? 0)\n"
        description += "Average price:  $\(portfolio.avgPrice ?? 0)\n"
        description += "Percent gain:  \(portfolio.percentGain ?? 0)%\n"
        return description
        
    }
    

   
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
    
    
    func setUpViews(){
        
        view.backgroundColor = .main_background
        
        view.addSubviews(views: [portfolioSymbol, descTextView])
        
        portfolioSymbol.anchor(view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: view.frame.size.height/4, leftConstant: 10, bottomConstant: 0, rightConstant: 10, widthConstant: 0, heightConstant: 0)
        
        descTextView.anchor(portfolioSymbol.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 30, leftConstant: 10, bottomConstant: 0, rightConstant: 10, widthConstant: 0, heightConstant: 0)
        
    }
    
   
}
