//
//  AccountVC.swift
//  MarketMania
//
//  Created by Thor Larson on 3/16/21.
//

import UIKit
import Firebase

class AccountVC: UIViewController {
    
    //
    // MARK: View Lifecycle
    //
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpViews()
    }
    
    //
    // MARK: Functions
    //
    
    @objc func handleLogout() {
        do {
            try Auth.auth().signOut()
            globalCurrentUser = nil
            let loginVC = LoginVC()
            loginVC.modalPresentationStyle = .fullScreen
            present(loginVC, animated: true, completion: nil)
        } catch {
            print("Error signing out: " +  error.localizedDescription)
        }
    }
    
    //
    // MARK: UI Setup
    //
    
    lazy var logoutButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Logout", for: .normal)
        btn.addTarget(self, action: #selector(handleLogout), for: .touchUpInside)
        return btn
    }()
    
    func setUpViews() {
        self.view.backgroundColor = .yellow
        
        self.view.addSubviews(views: [logoutButton])
        
        logoutButton.anchorCenterSuperview()
    }
    
    
}
