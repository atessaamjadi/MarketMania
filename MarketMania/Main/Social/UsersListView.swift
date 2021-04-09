//
//  UsersListView.swift
//  MarketMania
//
//  Created by Mitch Alley on 4/5/21.
//

import UIKit

class UsersListView: UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
        
        collectionView2.delegate = self
        collectionView2.dataSource = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    let userListLabel: UILabel = {
        let label = UILabel()
        label.add(text: "Name", font: UIFont(boldWithSize: 17), textColor: .white)
        label.textAlignment = .center
        return label
    }()
    
    let userListRank: UILabel = {
        let label = UILabel()
        label.add(text: "Rank", font: UIFont(boldWithSize: 17), textColor: .white)
        label.textAlignment = .right
        return label
    }()
    
    //userlist collection view
    let collectionView2: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.translatesAutoresizingMaskIntoConstraints = false
        
        // register cells
        cv.register(usersListCell.self, forCellWithReuseIdentifier: "usersListCell")
        return cv
    }()
    
    func setUpViews() {
        
        userListRank.accessibilityIdentifier = "userListRank"
        userListLabel.accessibilityIdentifier = "userListLabel"
        collectionView2.accessibilityIdentifier = "collectionView2"
        
        contentView.addSubviews(views: [userListLabel, userListRank,
                                        collectionView2])
        
        
        userListLabel.anchor(contentView.topAnchor, left: contentView.leftAnchor, bottom: collectionView2.topAnchor, right: nil, topConstant: 20, leftConstant: 10, bottomConstant: 5, rightConstant: 20, widthConstant: 0, heightConstant: 0)

        collectionView2.anchor(userListLabel.bottomAnchor, left: contentView.leftAnchor, bottom: contentView.safeAreaLayoutGuide.bottomAnchor, right: contentView.rightAnchor, topConstant: 0, leftConstant: 10, bottomConstant: 0, rightConstant: 10, widthConstant: 0, heightConstant: 0)
        
        userListRank.anchor(contentView.topAnchor, left: nil, bottom: collectionView2.topAnchor, right: contentView.rightAnchor, topConstant: 20, leftConstant: 20, bottomConstant: 5, rightConstant: 10, widthConstant: 0, heightConstant: 0)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 21
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "usersListCell", for: indexPath) as! usersListCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height/5)
    }
    
}

//cells for userlist
class usersListCell: UICollectionViewCell {

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .systemGray2
        
        setUpViews()
    }
    
    let tempLabel: UILabel = {
        let label = UILabel()
        label.add(text: "testing", font: UIFont(name: "PingFangHK-Regular", size: 15)!, textColor: .black)
        label.textAlignment = .center
        return label
    }()
    
    func setUpViews() {
        
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 5
        self.backgroundColor = UIColor(hex: "3A3E50")
        
//        contentView.addSubview(tempLabel)
        
//        tempLabel.anchor(contentView.topAnchor, left: contentView.leftAnchor, bottom: nil, right: nil, topConstant: 5, leftConstant: 5, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
      
       
       
    }
}
