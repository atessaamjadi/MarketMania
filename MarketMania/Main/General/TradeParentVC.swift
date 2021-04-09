//
//  TradeParentVC.swift
//  MarketMania
//
//  Created by Thor Larson on 4/8/21.
//

import UIKit

class TradeParentVC: UIViewController {
    
    var tradeInfoViewBottomConstraint: NSLayoutConstraint?
    var tradeInfoViewHeightConstraint: NSLayoutConstraint?
    var tradeInfoHeight: CGFloat = 0
    
    override func viewDidLoad() {
        setUpViews()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    //
    // MARK: Functions
    //
    
    @objc func handleDismiss() {
        print("called")
        self.view.endEditing(true)
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func keyboardWillShow(notification: Notification) {
    
        let keyboardSize = (notification.userInfo? [UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
        let keyboardHeight = keyboardSize?.height
        
        self.tradeInfoViewHeightConstraint?.constant = tradeInfoHeight
        self.tradeInfoViewBottomConstraint?.constant = -keyboardHeight!
        
        UIView.animate(withDuration: 0.5){
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func keyboardWillHide(notification: Notification) {
        
        self.tradeInfoViewHeightConstraint?.constant = (tradeInfoHeight == 0) ? 0 : tradeInfoHeight + view.safeAreaInsets.bottom
        self.tradeInfoViewBottomConstraint?.constant = 0

        UIView.animate(withDuration: 0.5){
            self.view.layoutIfNeeded()
        }
    }
    
    //
    // MARK: UI Setup
    //
    
    lazy var dismissBtn: UIButton = {
        let btn = UIButton(frame: CGRect(x: 0, y: 0, width: 16, height: 16))
        btn.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
        btn.setImage(UIImage(named: "dismiss_btn")?.withRenderingMode(.alwaysOriginal), for: .normal)
        return btn
    }()
    
    lazy var tradeInfoView: TradeInfoView = {
        let vw = TradeInfoView()
        vw.tradeParentVC = self
        return vw
    }()
    
    func setUpViews() {
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: dismissBtn)
        
        self.view.addSubviews(views: [tradeInfoView])
        
        if (tradeInfoView.tradeInfo.count == 0) {
            tradeInfoView.isHidden = true
        }
        
        tradeInfoView.anchor(nil, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        tradeInfoHeight = (tradeInfoView.tradeInfo.count > 0) ? (17 + CGFloat(6 * (tradeInfoView.tradeInfo.count - 1)) + CGFloat(55 * tradeInfoView.tradeInfo.count)) : 0
        tradeInfoViewHeightConstraint = tradeInfoView.heightAnchor.constraint(equalToConstant: (tradeInfoHeight == 0) ? 0 : tradeInfoHeight + view.safeAreaInsets.bottom)
        tradeInfoViewBottomConstraint = tradeInfoView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        
        //
        // Keep getting constraint warning when setting the post info view height to 0
        //
        
        tradeInfoViewBottomConstraint?.isActive = true
        tradeInfoViewHeightConstraint?.isActive = true
    }
    
}

