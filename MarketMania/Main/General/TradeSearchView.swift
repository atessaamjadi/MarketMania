//
//  TradeSearchView.swift
//  MarketMania
//
//  Created by Thor Larson on 4/8/21.
//

import UIKit
import Firebase

// screen displaying each stock available to buy
// navigates to TradeSelectAmountVC
class TradeSearchView: CUIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
    
    var searchBar: UISearchBar?
    var stocks = [Stock]()
    
    //
    // MARK: Functions
    //
    
    func fetchStocks() {
        // TODO
        
        // run async function that reloads view once data is fetched
        getWinners { response in
            // UI updates are only allowed in main queue
            DispatchQueue.main.async {
                self.stocks = response
                self.collectionView.reloadData()
            }
        }
    }
    
    
    //
    // MARK: Collection View
    //
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return stocks.count
        } else {
            return 10
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let stockCell = collectionView.dequeueReusableCell(withReuseIdentifier: "stockCell", for: indexPath) as! TradeStockCell
        
        if indexPath.item == 0 {
            stockCell.separator.isHidden = true
        }
        
        if stocks.count > 0 && indexPath.section == 0 {
            stockCell.nameLabel.text = stocks[indexPath.item].companyName
            stockCell.usernameLabel.text = stocks[indexPath.item].symbol
        }

        return stockCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.frame.width, height: 58)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if (kind == UICollectionView.elementKindSectionHeader) {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath) as! TradeSearchHeaderCell
            
            if indexPath.section == 0 {
                header.titleLabel.text = "Top Movers"
            } else {
                header.titleLabel.text = "All"
            }
            
            return header
            
        } else {
            return UICollectionReusableView()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: self.frame.width, height: 40)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        if let window = UIApplication.shared.keyWindow {
            window.endEditing(true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let tradeSelectAmountVC = TradeSelectAmountVC()
        tradeSelectAmountVC.tradeInfoView.tradeInfo = tradeSearchVC.tradeInfoView.tradeInfo
        
        for i in 0..<(tradeSelectAmountVC.tradeInfoView.tradeInfo.count) {
            tradeSelectAmountVC.tradeInfoView.tradeInfo.remove(at: i)
            break
        }
        
        let stock = stocks[indexPath.item]
        tradeSelectAmountVC.tradeInfoView.tradeInfo.append(stock)
        
        tradeSearchVC.view.endEditing(true)
        tradeSearchVC.navigationController?.pushViewController(tradeSelectAmountVC, animated: true)
    }
    
    //
    // MARK: UI Setup
    //
    
    var tradeSearchVC = TradeSearchVC()
    
    lazy var collectionView: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        cv.delegate = self
        cv.dataSource = self
        cv.backgroundColor = .clear
        return cv
    }()
    
    override func setUpViews() {
                
        collectionView.register(TradeStockCell.self, forCellWithReuseIdentifier: "stockCell")
        collectionView.register(TradeSearchHeaderCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header")
        
        self.addSubview(collectionView)
        collectionView.fillSuperview()
    }
}

