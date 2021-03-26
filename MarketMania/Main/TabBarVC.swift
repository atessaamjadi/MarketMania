//
//  TabBarVC.swift
//  BadgerBytes
//
//  Created by Thor Larson on 2/18/21.
//

import UIKit
import Firebase

class TabBarVC: UITabBarController {
    
    override func viewDidLoad() {
                
        let currentUser = Auth.auth().currentUser
        
        if currentUser == nil {
            // Waits unitil the tab bar is loaded then runs this code to present the login view controller
            DispatchQueue.main.async {
                let loginVC = LoginVC()
                loginVC.modalPresentationStyle = .fullScreen
                self.present(loginVC, animated: false, completion: nil)
            }
        }else{  //TODO - Make a loading screen to remove this, also big performace issue here
            fetchUser {
                self.view.window?.resignKey()
                let tabBarVC = UIApplication.shared.keyWindow?.rootViewController as! TabBarVC
                tabBarVC.setUpViewControllers()
                
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
        
        setUpViewControllers()
    }
    
    func setUpViewControllers() {
        
        // Initialize each tab bar view controller
        
        let controllersCustomer = [add(vc: HomeVC(), name: "Home", icon: UIImage(named: "home_icon")!),
                                   add(vc: SearchVC(), name: "Search", icon: UIImage(named: "search_icon")!),
                                   add(vc: SocialVC(), name: "Social", icon: UIImage(named: "social_icon")!),
                                   add(vc: AccountVC(), name: "Account", icon: UIImage(named: "account_icon")!)]
        // Add all view controllers
        self.viewControllers = controllersCustomer
        self.selectedIndex = 0

    }
    
    func add(vc: UIViewController, name: String, icon: UIImage) -> UINavigationController {
        vc.tabBarItem = UITabBarItem(title: name, image: icon.withRenderingMode(.alwaysTemplate), selectedImage: nil)
        vc.title = name
        vc.view.backgroundColor = .black
        vc.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        return UINavigationController(rootViewController: vc)
    }

    
}

