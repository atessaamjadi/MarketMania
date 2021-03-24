//
//  SearchVC.swift
//  MarketMania
//
//  Created by Thor Larson on 3/16/21.
//

import UIKit

class SearchVC: UIViewController {
    
    //
    // MARK: View Lifecycle
    //
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView1.delegate = self
        collectionView1.dataSource = self
        
        collectionView2.delegate = self
        collectionView2.dataSource = self
        
        self.navigationItem.titleView = searchBar

        
        setUpViews()
    }
    
    //
    // MARK: Functions
    //
    
    //
    // MARK: UI Setup
    //
    
    let searchBar: UISearchBar = {
        let sb = UISearchBar()
        sb.searchBarStyle = UISearchBar.Style.prominent
        sb.placeholder = " Search..."
        sb.sizeToFit()
        sb.isTranslucent = false
        return sb
    }()
    
    let exploreLabel: UILabel = {
        let label = UILabel()
        label.add(text: "Explore", font: UIFont.boldSystemFont(ofSize: 25.0), textColor: .darkGray)
        label.textAlignment = .center
        return label
        
    }()
    
    let mostPopularLabel: UILabel = {
        let label = UILabel()
        label.add(text: "Most popular", font: UIFont(name: "PingFangHK-Regular", size: 15)!, textColor: .gray)
        label.textAlignment = .center
        return label
    }()
    
    //most popular collection view
    let collectionView1: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .menu_white
        cv.translatesAutoresizingMaskIntoConstraints = false
        
        // register cells
        cv.register(mostPopularCell.self, forCellWithReuseIdentifier: "mostPopularCell")
        return cv
    }()
    
    let sectorsLabel: UILabel = {
        let label = UILabel()
        label.add(text: "Sectors", font: UIFont(name: "PingFangHK-Regular", size: 15)!, textColor: .gray)
        label.textAlignment = .center
        return label
    }()
    
    //sectors collection view
    let collectionView2: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .menu_white
        cv.translatesAutoresizingMaskIntoConstraints = false
        
        // register cells
        cv.register(sectorCell.self, forCellWithReuseIdentifier: "sectorCell")
        return cv
    }()
    
    func setUpViews() {
        
        view.addSubviews(views: [exploreLabel, mostPopularLabel, collectionView1, sectorsLabel, collectionView2])
        
        //search bar anchor before it became the navigation title view
//        searchBar.anchor(view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: exploreLabel.topAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 10, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        exploreLabel.anchor(view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: mostPopularLabel.topAnchor, right: nil, topConstant: 20, leftConstant: 10, bottomConstant: 20, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        mostPopularLabel.anchor(exploreLabel.bottomAnchor, left: view.leftAnchor, bottom: collectionView1.topAnchor, right: nil, topConstant: 0, leftConstant: 10, bottomConstant: 5, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        collectionView1.heightAnchor.constraint(equalTo: collectionView1.widthAnchor, multiplier: 0.4).isActive = true

        collectionView1.anchor(mostPopularLabel.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 0, leftConstant: 10, bottomConstant: 10, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        sectorsLabel.anchor(collectionView1.bottomAnchor, left: view.leftAnchor, bottom: collectionView2.topAnchor, right: nil, topConstant: 20, leftConstant: 10, bottomConstant: 5, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        collectionView2.anchor(sectorsLabel.bottomAnchor, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 10, bottomConstant: 0, rightConstant: 10, widthConstant: 0, heightConstant: 0)

    }
}

extension SearchVC: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == collectionView1.self {
            return CGSize(width: collectionView.frame.width/2.5, height: collectionView.frame.width/2.5)
        }
        
        return CGSize(width: (collectionView.frame.width/3)-10, height: collectionView.frame.width/3)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == collectionView1.self {
            
            //**** Commented out for now to see UI
    //        print(winners.count)
    //        return winners.count
            
            return 10
        }
        
        return 21
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == collectionView1.self {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "mostPopularCell", for: indexPath) as! mostPopularCell
            return cell
        }
        
        //**** Commented out for now to see UI
        //let stock = winners[indexPath.row]
        
//        cell.tickerLabel.text = stock.symbol
//        cell.nameLabel.text = stock.companyName
//        cell.moveLabel.text = String((stock.changePercent ?? 0.0))
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "sectorCell", for: indexPath) as! sectorCell
        return cell
       
    }
}

class mostPopularCell: UICollectionViewCell {
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .systemGreen
        
        setUpViews()
    }
    
    func setUpViews() {
        
    }
}

class sectorCell: UICollectionViewCell {
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .systemTeal
        
        setUpViews()
    }
    
    func setUpViews() {
        
    }
}
