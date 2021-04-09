//
//  TradeInfoView.swift
//  MarketMania
//
//  Created by Thor Larson on 4/8/21.
//

import UIKit

class TradeInfoView: CUIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var tradeInfo: [Stock] = []
    var tradeParentVC = TradeParentVC()

    //
    // MARK: Collection View
    //
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tradeInfo.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let tradeInfoCell = collectionView.dequeueReusableCell(withReuseIdentifier: "tradeInfoCell", for: indexPath) as! TradeInfoCell
        
        if tradeInfo.count > 0 {
            
            tradeInfoCell.setViewsWith(tradeInfo[indexPath.item])
            
//            if tradeInfo[indexPath.item].type == .User {
//                postInfoCell.circularImage()
//            }
        }
        
        return tradeInfoCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.collectionView.frame.width, height: 55)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
                
        let nextVC = TradeSearchVC()
        nextVC.tradeSearchView.fetchStocks()
        nextVC.tradeInfoView.tradeInfo = tradeInfo
        
        tradeParentVC.view.endEditing(true)
        tradeParentVC.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    //
    // MARK: UI Setup
    //
        
    lazy var collectionView: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        cv.delegate = self
        cv.dataSource = self
        cv.backgroundColor = .clear
        return cv
    }()
    
    override func setUpViews() {
        
        collectionView.register(TradeInfoCell.self, forCellWithReuseIdentifier: "tradeInfoCell")
        
        self.addSubviews(views: [collectionView])
        
        self.backgroundColor = .vc_background
        
        collectionView.anchor(topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 8, leftConstant: 10, bottomConstant: 0, rightConstant: 10, widthConstant: 0, heightConstant: 0)
    }
}

class TradeInfoCell: CUICollectionViewCell {
    
    let imageView: CUImageView = {
        let iv = CUImageView()
        iv.image = UIImage(named: "person1_profile")
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    let titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.add(text: "Ava Wilson", font: UIFont(regularWithSize: 16), textColor: .main_label)
        return lbl
    }()
    
    let subtitleLabel: UILabel = {
        let lbl = UILabel()
        lbl.add(text: "@ava_wilson22", font: UIFont(regularWithSize: 14), textColor: .subtitle_label)
        return lbl
    }()
    
    func circularImage() {
        imageView.layer.cornerRadius = 41 / 2
        imageView.clipsToBounds = true
    }
    
    func setViewsWith(_ stock: Stock) {
        titleLabel.text = stock.companyName
        subtitleLabel.text = stock.symbol
    }
    
    override func setUpViews() {
        
        self.contentView.addSubviews(views: [imageView, titleLabel, subtitleLabel])
    
        self.contentView.backgroundColor = .user_cell
        self.contentView.layer.cornerRadius = 3
        self.contentView.layer.masksToBounds = true
        
        imageView.anchor(topAnchor, left: leftAnchor, bottom: bottomAnchor, right: nil, topConstant: 7, leftConstant: 7, bottomConstant: 7, rightConstant: 0, widthConstant: 41, heightConstant: 0)
        
        titleLabel.anchor(imageView.topAnchor, left: imageView.rightAnchor, bottom: nil, right: rightAnchor, topConstant: 3, leftConstant: 13, bottomConstant: 0, rightConstant: 5, widthConstant: 0, heightConstant: 19)
        
        subtitleLabel.anchor(titleLabel.bottomAnchor, left: titleLabel.leftAnchor, bottom: nil, right: titleLabel.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 19)
    
    }
}

