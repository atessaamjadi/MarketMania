//
//  HomeVC.swift
//  MarketMania
//
//  Created by Thor Larson on 3/16/21.
//

import UIKit

class HomeVC: UIViewController {
    
    //
    // MARK: View Lifecycle
    //
    

 
    override func viewDidLoad() {
        super.viewDidLoad()
       
        setUpViews()
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    //hide the navigation bar with "Home" title
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    //
    // MARK: Functions
    //
    
    //
    // MARK: UI Setup
    //
    

    //collection view
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .main_background
        cv.translatesAutoresizingMaskIntoConstraints = false
        
        // register cells
        cv.register(WelcomeView.self, forCellWithReuseIdentifier: "welcomeView")
        cv.register(TopMovesView.self, forCellWithReuseIdentifier: "topMovesView")
        cv.register(WatchlistView.self, forCellWithReuseIdentifier: "watchListView")
        
        return cv
    }()
    

    func setUpViews() {
        
        view.addSubview(collectionView)
        
        collectionView.fillSuperview()

    }
}

extension HomeVC: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0 {
            return CGSize(width: collectionView.frame.width, height: collectionView.frame.height/5)
        }
        if indexPath.section == 1 {
            return CGSize(width: collectionView.frame.width, height: collectionView.frame.height/4)
        }
        
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height/1.5)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "welcomeView", for: indexPath) as! WelcomeView
            return cell
        }
        
        else if indexPath.section == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "topMovesView", for: indexPath) as! TopMovesView
            cell.homeVC = self
            return cell
        }
        
        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "watchListView", for: indexPath) as! WatchlistView
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
}












