//
//  TradeSelectAmountVC.swift
//  MarketMania
//
//  Created by Thor Larson on 4/9/21.
//


import UIKit
import Firebase

class TradeSelectAmountVC: TradeParentVC, UITextViewDelegate {
    
    //
    // MARK: Functions
    //
    
    @objc func handleSubmit() {
        self.view.endEditing(true)
        self.dismiss(animated: true, completion: nil)
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

