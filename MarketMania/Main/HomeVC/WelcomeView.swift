//
//  WelcomeView.swift
//  MarketMania
//
//  Created by Atessa Amjadi on 3/24/21.
//

import UIKit


class WelcomeView: UICollectionViewCell {
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .menu_white
        
        setUpViews()
    }
    
    let welcomeLabel: UILabel = {
        let label = UILabel()
        label.add(text: "Welcome back " + (globalCurrentUser?.firstName ?? ""), font: UIFont.boldSystemFont(ofSize: 25.0), textColor: .darkGray)
        label.textAlignment = .center
        return label
        
    }()
    
    let tempSarcasticLabel: UILabel = {
        let label = UILabel()
        label.add(text: "Ready to lose more $ ?", font: UIFont(name: "PingFangHK-Regular", size: 18)!, textColor: .gray)
        label.textAlignment = .center
        return label
    }()
    
    func setUpViews() {
        
        contentView.addSubviews(views: [welcomeLabel, tempSarcasticLabel])
        
        welcomeLabel.anchor(contentView.safeAreaLayoutGuide.topAnchor, left: contentView.leftAnchor, bottom: nil, right: nil, topConstant: 30, leftConstant: 10, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        tempSarcasticLabel.anchor(welcomeLabel.bottomAnchor, left: contentView.leftAnchor, bottom: nil, right: nil, topConstant: 10, leftConstant: 20, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
       
    }
    
}
