//
//  PopularView.swift
//  MarketMania
//
//  Created by Atessa Amjadi on 4/4/21.
//

import UIKit

class PopularView: UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var popularStocks: [Stock] = []
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        collectionView1.delegate = self
        collectionView1.dataSource = self
        
        getMostActive { response in
            // UI updates are only allowed in main queue
            DispatchQueue.main.async {
                //print("winners", response)
                self.popularStocks = response
                self.collectionView1.reloadData()
            }
        }
        
        setUpViews()
    }
    
   
    let exploreLabel: UILabel = {
        let label = UILabel()
        label.add(text: "Explore", font: UIFont(boldWithSize: 25), textColor: .white)
        label.textAlignment = .center
        return label
        
    }()
    
    let mostPopularLabel: UILabel = {
        let label = UILabel()
        label.add(text: "Most popular", font: UIFont(name: "PingFangHK-Medium", size: 15)!, textColor: .white)
        label.textAlignment = .center
        return label
    }()
    
    
    //most popular collection view
    let collectionView1: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.translatesAutoresizingMaskIntoConstraints = false
        
        // register cells
        cv.register(mostPopularCell.self, forCellWithReuseIdentifier: "mostPopularCell")
        return cv
    }()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (popularStocks.count != 0) {
            return popularStocks.count
        }
        return 6
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/2.5, height: collectionView.frame.width/2.5)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if (popularStocks.count != 0) {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "mostPopularCell", for: indexPath) as! mostPopularCell
            
            let stock = popularStocks[indexPath.row]
            
            cell.tickerLabel.text = stock.symbol
            cell.nameLabel.text = stock.companyName
            cell.moveLabel.text = String((stock.changePercent ?? 0.0)) + "%"

            cell.accessibilityIdentifier = "popular"
            
            return cell
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "mostPopularCell", for: indexPath) as! mostPopularCell
        return cell
    }
    
   
    
    
    func setUpViews() {
        
        contentView.addSubviews(views: [exploreLabel, mostPopularLabel, collectionView1])
        
        exploreLabel.anchor(contentView.topAnchor, left: contentView.leftAnchor, bottom: mostPopularLabel.topAnchor, right: nil, topConstant: 20, leftConstant: 10, bottomConstant: 20, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        mostPopularLabel.anchor(exploreLabel.bottomAnchor, left: contentView.leftAnchor, bottom: collectionView1.topAnchor, right: nil, topConstant: 0, leftConstant: 10, bottomConstant: 5, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        collectionView1.heightAnchor.constraint(equalTo: collectionView1.widthAnchor, multiplier: 0.4).isActive = true

        collectionView1.anchor(mostPopularLabel.bottomAnchor, left: contentView.leftAnchor, bottom: contentView.bottomAnchor, right: contentView.rightAnchor, topConstant: 0, leftConstant: 10, bottomConstant: 10, rightConstant: 0, widthConstant: 0, heightConstant: 0)
       
    }
    
   
    
}

class mostPopularCell: UICollectionViewCell {
    
    let tickerLabel: UILabel = {
        let label = UILabel()
        label.add(text: "Placeholder", font: UIFont(boldWithSize: 18), textColor: .white)
        label.textAlignment = .left
        return label
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.add(text: "Subtext placeholder", font: UIFont(regularWithSize: 11), textColor: .white)
        label.textAlignment = .left
        label.numberOfLines = 2
        return label
    }()
    
    let moveLabel: UILabel = {
        let label = UILabel()
        label.add(text: "Move %", font: UIFont(boldWithSize: 26), textColor: .white)
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        backgroundColor = UIColor(hex: "3A3E50")
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 5
        
        setUpViews()
    }
    
    func setUpViews() {
        
        contentView.addSubviews(views: [tickerLabel, nameLabel, moveLabel])
        
        tickerLabel.anchor(contentView.topAnchor, left: contentView.leftAnchor, bottom: nil, right: contentView.rightAnchor, topConstant: 20, leftConstant: 10, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        nameLabel.anchor(tickerLabel.bottomAnchor, left: contentView.leftAnchor, bottom: nil, right: contentView.rightAnchor, topConstant: 5, leftConstant: 10, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        moveLabel.anchor(nil, left: contentView.leftAnchor, bottom: contentView.bottomAnchor, right: contentView.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 20, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
