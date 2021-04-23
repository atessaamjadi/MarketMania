//
//  TradeSearchVC.swift
//  MarketMania
//
//  Created by Thor Larson on 4/8/21.
//

import UIKit

class TradeSearchVC: TradeParentVC {
    
    //
    // MARK: Functions
    //
    
    @objc func handleEveryone() {
        
    }
    
    //
    // MARK: UI Setup
    //
    
    let descLabel: UILabel = {
        let lbl = UILabel()
        lbl.add(text: "Search:", font: UIFont(regularWithSize: 16), textColor: .subtitle_label)
        return lbl
    }()
    
    let searchTextField: UITextField = {
        let tf = UITextField()
        tf.textColor = .main_label
        tf.attributedPlaceholder = NSAttributedString(string: "Stock, symbol, name", attributes: [.foregroundColor: UIColor(hex: "8F8F8F")])
        tf.font = UIFont(regularWithSize: 16)
        tf.keyboardAppearance = .dark
        tf.tintColor = .main_label
        tf.autocorrectionType = .no
        return tf
    }()
    
    lazy var everyoneBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.layer.cornerRadius = 5
        btn.backgroundColor = UIColor(hex: "C9C9C9")
        btn.setTitle("Random", for: .normal)
        btn.setTitleColor(.vc_background, for: .normal)
        btn.addTarget(self, action: #selector(handleEveryone), for: .touchUpInside)
        return btn
    }()
    
    let separator = LineView(color: .separator)
    
    lazy var tradeSearchView: TradeSearchView = {
        let sv = TradeSearchView()
        sv.tradeSearchVC = self
        return sv
    }()
    
    override func setUpViews() {
        
        self.view.addSubviews(views: [descLabel, searchTextField, everyoneBtn, separator, tradeSearchView])
        super.setUpViews()

        self.title = "Choose Stock"
        self.view.backgroundColor = .vc_background
        //searchTextField.becomeFirstResponder()
        
//        everyoneBtn.anchor(view.safeAreaLayoutGuide.topAnchor, left: nil, bottom: nil, right: view.rightAnchor, topConstant: 8, leftConstant: 0, bottomConstant: 0, rightConstant: 12, widthConstant: 90, heightConstant: 28)
//
//        descLabel.anchor(nil, left: view.leftAnchor, bottom: nil, right: nil, topConstant: 0, leftConstant: 5, bottomConstant: 0, rightConstant: 0, widthConstant: 60, heightConstant: 19)
//        descLabel.centerYAnchor.constraint(equalTo: everyoneBtn.centerYAnchor).isActive = true
//
////        searchTextField.anchor(nil, left: descLabel.rightAnchor, bottom: nil, right: everyoneBtn.leftAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 15, widthConstant: 0, heightConstant: 19)
////        searchTextField.centerYAnchor.constraint(equalTo: everyoneBtn.centerYAnchor, constant: 0.5).isActive = true
//
//        separator.anchor(everyoneBtn.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 8, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 1)
//
//        tradeSearchView.anchor(separator.bottomAnchor, left: view.leftAnchor, bottom: (tradeInfoView.isHidden) ? view.bottomAnchor : self.tradeInfoView.topAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        tradeSearchView.anchor(view.topAnchor, left: view.leftAnchor, bottom: (tradeInfoView.isHidden) ? view.bottomAnchor : self.tradeInfoView.topAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
    }
}
