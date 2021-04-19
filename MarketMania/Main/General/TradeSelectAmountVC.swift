//
//  TradeSelectAmountVC.swift
//  MarketMania
//
//  Created by Thor Larson on 4/9/21.
//


import UIKit
import Firebase

// select amount of stocks to buy
// contains a TradeInfoView
class TradeSelectAmountVC: TradeParentVC, UITextViewDelegate {
    
    var symbol: String = ""
    let buying: Bool = true
    
    //
    // MARK: Functions
    //
    
    @objc func handleSubmit() {
        // check valid input
        guard amountTextField.text != "" else {return}
        
        // get relevant variables
        let numBought: Float = Float(amountTextField.text ?? "-1.0") ?? -1.0
        let symbolBought: String = tradeInfoView.tradeInfo[0].symbol ?? ""
        
        globalCurrentUser?.buyStock(symbol: symbolBought, numShares: numBought, completion: {
            error, _ in
            
            if error != nil {
                // TODO: show popup
                self.view.endEditing(true)
                self.dismiss(animated: true, completion: nil)
                return
            }
            
            DispatchQueue.main.async {
                self.view.endEditing(true)
                self.dismiss(animated: true, completion: nil)
            }
            
        })
        
        
    }
    
    //
    // MARK: UI Setup
    //
    
    lazy var submitBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.layer.cornerRadius = 5
        btn.backgroundColor = UIColor(hex: "C9C9C9")
        btn.setTitle("Submit", for: .normal)
        btn.setTitleColor(.vc_background, for: .normal)
        btn.addTarget(self, action: #selector(handleSubmit), for: .touchUpInside)
        btn.frame = CGRect(x: 0, y: 0, width: 90, height: 28)
        return btn
    }()
    
    let amountTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "0"
        tf.keyboardType = .numberPad
        tf.font = UIFont(boldWithSize: 60)
        tf.textColor = .white
        tf.textAlignment = .center
        return tf
    }()
    
    let separator = LineView(color: .separator)
    
    override func setUpViews() {
        
        amountTextField.becomeFirstResponder()
        
        self.view.addSubviews(views: [separator, amountTextField])
        super.setUpViews()
        
        self.view.backgroundColor = .main_background
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: submitBtn)
        
        amountTextField.anchor(view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 20, leftConstant: 20, bottomConstant: 0, rightConstant: 20, widthConstant: 0, heightConstant: 200)
                
        separator.anchor(nil, left: view.leftAnchor, bottom: tradeInfoView.topAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 1)
        
    }
}

