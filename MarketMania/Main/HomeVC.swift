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
        
        view.addSubview(collectionView)
        
        setUpViews()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        
    }
    
    //
    // MARK: Functions
    //
    
    //
    // MARK: UI Setup
    //
    
    
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        return cv
    }()
    
    let topMovesLabel: UILabel = {
        let label = UILabel()
        label.add(text: "Top Moves", font: UIFont(name: "PingFangHK-Regular", size: 13)!, textColor: .gray)
        label.textAlignment = .center
        return label
    }()
    
    
    
    func setUpViews() {
        //self.view.backgroundColor = .red
        
        view.addSubviews(views: [collectionView, topMovesLabel])
       
        collectionView.backgroundColor = .white
        
        
        //make the collection view only the height of one cell
        collectionView.heightAnchor.constraint(equalTo: collectionView.widthAnchor, multiplier: 0.4).isActive = true
        
        collectionView.anchor(view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: view.frame.height/2.5, leftConstant: 20, bottomConstant: 0, rightConstant: 20, widthConstant: 0, heightConstant: 0)

        topMovesLabel.anchor(nil, left: view.leftAnchor, bottom: collectionView.topAnchor, right: nil, topConstant: 0, leftConstant: 20, bottomConstant: 10, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
       
    }
}

extension HomeVC: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/2.5, height: collectionView.frame.width/2.5)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        
        cell.backgroundColor = .blue
        
        return cell
    }

}
