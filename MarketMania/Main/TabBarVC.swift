//
//  TabBarVC.swift
//  BadgerBytes
//
//  Created by Thor Larson on 2/18/21.
//

import UIKit
import Firebase
import Foundation

class TabBarVC: UITabBarController {
    
    override func viewDidLoad() {
                
        var currentUser = Auth.auth().currentUser
        
        // for testing -- if test adds this argument, the current session is set to nil bringing user to login screen
        if ProcessInfo.processInfo.arguments.contains("isUITestingLogin") {
            currentUser = nil
        }
        
        if currentUser == nil {
            // Waits unitil the tab bar is loaded then runs this code to present the login view controller
            DispatchQueue.main.async {
                let loginVC = LoginVC()
                loginVC.modalPresentationStyle = .fullScreen
                self.present(loginVC, animated: false, completion: nil)
            }
        }else{  //TODO - Make a loading screen to remove this, also big performace issue here
            fetchUser {
                DispatchQueue.main.async {
                    self.view.window?.resignKey()
                    let tabBarVC = UIApplication.shared.keyWindow?.rootViewController as! TabBarVC
                    tabBarVC.setUpViewControllers()
                }
                
                
            }
        }
        // pop up a loading screen modal until all the necessary data is loaded
//        DispatchQueue.main.async {
//            let loadScreenVC = LoadVC()
//            loadScreenVC.modalPresentationStyle = .fullScreen
//            self.present(loadScreenVC, animated: false, completion: {
//                self.setUpViewControllers()
//            })
//        }
        button = UIButton(type: .custom)
        button.frame = CGRect(x: 0, y:0, width: 75, height: 75)
        button.center.x = view.center.x
        button.center.y = view.frame.maxY * 0.93
        button.layer.cornerRadius = 0.5 * button.bounds.size.width
        button.clipsToBounds = true
        button.setImage(UIImage(systemName: "dollarsign.circle.fill"), for: .normal)
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.addTarget(self, action: #selector(test), for: .touchDown)
        button.tintColor = .primary_purple
        
        buyButton = UIButton(type: .custom)
        buyButton.frame = CGRect(x: 0, y:0, width: 70, height: 70)
        buyButton.center.x = view.center.x
        buyButton.center.y = view.frame.maxY * 0.93
        buyButton.layer.cornerRadius = 0.5 * button.bounds.size.width
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
        sellButton.layer.cornerRadius = 0.5 * button.bounds.size.width
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
        self.view.addSubview(button)
        
        setUpViewControllers()
    }
    
    var button : UIButton!
    var buyButton : UIButton!
    var sellButton : UIButton!
    
    var buyButtonLabel : UILabel!
    var sellButtonLabel : UILabel!
    
    var buyCenter : CGPoint!
    var sellCenter : CGPoint!
    
    
    
    var toggle = true
    
    @objc func test(sender: UIButton){
        if(toggle){
            sender.setImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
            toggle = false
            //expand buttons
            UIView.animate(withDuration: 0.3, animations: {
                self.buyButton.alpha = 1
                self.sellButton.alpha = 1
                self.buyButton.center = CGPoint(x: (self.view.center.x * 0.8), y: (self.view.frame.maxY * 0.85))
                self.sellButton.center = CGPoint(x: (self.view.center.x * 1.2), y: (self.view.frame.maxY * 0.85))
                self.buyButtonLabel.alpha = 1
                self.sellButtonLabel.alpha = 1
            })
        }else{
            sender.setImage(UIImage(systemName: "dollarsign.circle.fill"), for: .normal)
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
    
    @objc func buyFunc(sender: UIButton){
        //TODO
    }
    
    @objc func sellFunc(sender: UIButton){
        //TODO
    }
    
    func setUpViewControllers() {
        
        // Initialize each tab bar view controller
        
        let controllersCustomer = [add(vc: HomeVC(), name: "Home", icon: UIImage(named: "home_icon")!),
                                   add(vc: SearchVC(), name: "Search", icon: UIImage(named: "search_icon")!),
                                   UIViewController(),
                                   add(vc: SocialVC(), name: "Social", icon: UIImage(named: "social_icon")!),
                                   add(vc: AccountVC(), name: "Account", icon: UIImage(named: "account_icon")!)]
        // Add all view controllers
        self.viewControllers = controllersCustomer
        self.selectedIndex = 0
        
        self.tabBar.layer.masksToBounds = true
        self.tabBar.barTintColor = UIColor(hex: "202534")
        self.tabBar.tintColor = .white
        self.tabBar.layer.cornerRadius = 20
        self.tabBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        self.tabBar.unselectedItemTintColor = UIColor(hex: "686B75")
        self.tabBar.isTranslucent = true
        self.tabBar.backgroundColor = .clear
    
    }
    
    func add(vc: UIViewController, name: String, icon: UIImage) -> UINavigationController {
        vc.tabBarItem = UITabBarItem(title: name, image: icon.withRenderingMode(.alwaysTemplate), selectedImage: nil)
        vc.title = name
        vc.view.backgroundColor = .main_background
        vc.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        return UINavigationController(rootViewController: vc)
    }

    
}

