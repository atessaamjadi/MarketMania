//
//  TradeCells.swift
//  MarketMania
//
//  Created by Thor Larson on 4/9/21.
//

import UIKit

class TradeStockCell: CUICollectionViewCell {
    
    let separator = LineView(color: UIColor(hex: "6C6C6C"))
    
    let profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "person1_profile")
        iv.layer.cornerRadius = 40 / 2
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    let nameLabel: UILabel = {
        let lbl = UILabel()
        lbl.add(text: "Company Name", font: UIFont(regularWithSize: 16), textColor: .main_label)
        return lbl
    }()
    
    let usernameLabel: UILabel = {
        let lbl = UILabel()
        lbl.add(text: "Stock Symbol", font: UIFont(regularWithSize: 13), textColor: .subtitle_label)
        return lbl
    }()
    
    let infoButton: UIButton = {
        let btn = UIButton(type: .infoLight)
        btn.tintColor = .info_btn
        return btn
    }()
    
    override func setUpViews() {
        
        self.backgroundColor = .user_cell
        
        self.addSubviews(views: [separator, profileImageView, nameLabel, usernameLabel, infoButton])
        
        separator.anchor(topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 0, leftConstant: 11, bottomConstant: 0, rightConstant: 11, widthConstant: 0, heightConstant: 1)
        
        profileImageView.anchor(nil, left: leftAnchor, bottom: nil, right: nil, topConstant: 0, leftConstant: 11, bottomConstant: 0, rightConstant: 0, widthConstant: 40, heightConstant: 40)
        profileImageView.anchorCenterYToSuperview()
        
        nameLabel.anchor(profileImageView.topAnchor, left: profileImageView.rightAnchor, bottom: nil, right: infoButton.leftAnchor, topConstant: 5, leftConstant: 9, bottomConstant: 0, rightConstant: 5, widthConstant: 0, heightConstant: 17)
        
        usernameLabel.anchor(nameLabel.bottomAnchor, left: nameLabel.leftAnchor, bottom: nil, right: nameLabel.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 19)
        
        infoButton.anchor(nil, left: nil, bottom: nil, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 20, widthConstant: 18, heightConstant: 18)
        infoButton.anchorCenterYToSuperview()
    }
}

class TradeSearchHeaderCell: CUICollectionViewCell {
    
    let titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.add(text: "Top People", font: UIFont(regularWithSize: 17), textColor: .main_label)
        return lbl
    }()
    
    override func setUpViews() {
        
        self.backgroundColor = .clear
        
        self.addSubviews(views: [titleLabel])
        
        titleLabel.anchor(topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 8, leftConstant: 12, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 27)
    }
}

