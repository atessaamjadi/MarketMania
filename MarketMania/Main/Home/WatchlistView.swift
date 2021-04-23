//
//  WatchlistView.swift
//  MarketMania
//
//  Created by Atessa Amjadi on 3/24/21.
//



//UPDATE THIS WAS CHANGED TO PORTFOLIO

import UIKit

class WatchlistView: UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var UIportfolio: [PortfolioStock] = []
    
    var sellable: Bool = false
    var homeVC: HomeVC?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
        
        collectionView2.delegate = self
        collectionView2.dataSource = self
        
        // updates the collection view each time the list is updated
//        globalCurrentUser?.getWatchList(observer: { observedList in
//            guard observedList != [] else {return}
//            DispatchQueue.main.async {
//                self.watchList = observedList
//                self.collectionView2.reloadData()
//            }
//        })
        
        globalCurrentUser?.getPortfolio(observer: { error, portfolio in
            if let error = error {
                // error loading data
                print("Error loading user portfolio: \(error)")
                return
            }
            
            DispatchQueue.main.async {
                self.UIportfolio = portfolio
                self.collectionView2.reloadData()
            }
        })
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // ----------------------------------- //
    // MARK: Functions
    // ----------------------------------- //
    
    @objc func addPressed() {
        print("YUH!")
        sellable = !sellable
        self.collectionView2.reloadData()
    }
    
    // ----------------------------------- //
    // MARK: Elements
    // ----------------------------------- //
    
    let watchListLabel: UILabel = {
        let label = UILabel()
        label.add(text: "Portfolio", font: UIFont(boldWithSize: 17), textColor: .white)
        label.textAlignment = .center
        return label
    }()
        
    lazy var addButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sell", for: .normal)
        button.layer.borderColor = UIColor.subtitle_label.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 9
        button.addTarget(self, action: #selector(addPressed), for: .touchUpInside)
        return button
    }()
    
    //watchlist collection view
    let collectionView2: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.translatesAutoresizingMaskIntoConstraints = false
        
        // register cells
        cv.register(watchListCell.self, forCellWithReuseIdentifier: "watchListCell")
        return cv
    }()
    
    // ----------------------------------- //
    // MARK: SETUPVIEWS
    // ----------------------------------- //
    
    func setUpViews() {
        
        contentView.addSubviews(views: [watchListLabel, collectionView2])
        
        
        watchListLabel.anchor(contentView.topAnchor, left: contentView.leftAnchor, bottom: collectionView2.topAnchor, right: nil, topConstant: 20, leftConstant: 10, bottomConstant: 5, rightConstant: 20, widthConstant: 0, heightConstant: 0)
        
//        addButton.anchor(contentView.topAnchor, left: nil, bottom: collectionView2.topAnchor, right: contentView.rightAnchor, topConstant: 20, leftConstant: 10, bottomConstant: 5, rightConstant: 20, widthConstant: 40, heightConstant: 40)

        collectionView2.anchor(watchListLabel.bottomAnchor, left: contentView.leftAnchor, bottom: contentView.safeAreaLayoutGuide.bottomAnchor, right: contentView.rightAnchor, topConstant: 0, leftConstant: 10, bottomConstant: 0, rightConstant: 10, widthConstant: 40, heightConstant: 0)
             
    }
    
    // ----------------------------------- //
    // MARK: COLLECTIONVIEW FUNCTIONS
    // ----------------------------------- //
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return UIportfolio.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "watchListCell", for: indexPath) as! watchListCell
        
        if sellable {
            cell.backgroundColor = UIColor(red: 255, green: 0, blue: 0, alpha: 1)
        } else {
            cell.backgroundColor = UIColor(hex: "3A3E50")
        }
        
        cell.tempLabel.text = UIportfolio[indexPath.row].symbol
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height/5)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "watchListCell", for: indexPath) as! watchListCell
        
        // get name, then PortfolioStock
        if sellable {
            let toSell = UIportfolio[indexPath.row]
            let newVC = TradeSelectAmountVC()
            homeVC?.navigationController?.present(newVC, animated: true, completion: nil)
        }
        
        // else we want to get details on the selected cell
        else {
            let portfolioView = PortfolioDetailVC()
            portfolioView.portfolio = UIportfolio[indexPath.row]
            homeVC?.navigationController?.present(portfolioView, animated: true, completion: nil)
            
        }
        
        
    }
    
}

// ----------------------------------- //
// MARK: cells for watchlist
// ----------------------------------- //
class watchListCell: UICollectionViewCell {

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .systemGray2
        
        setUpViews()
    }
    
    // ----------------------------------- //
    // MARK: ELEMENTS
    // ----------------------------------- //
    
    let tempLabel: UILabel = {
        let label = UILabel()
        label.add(text: "testing", font: UIFont(name: "PingFangHK-Regular", size: 15)!, textColor: .white)
        label.textAlignment = .center
        return label
    }()
    
    // ----------------------------------- //
    // MARK: SETUPVIEWS
    // ----------------------------------- //
    
    func setUpViews() {
        
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 5
        self.backgroundColor = UIColor(hex: "3A3E50")
        
        contentView.addSubview(tempLabel)
        
//        tempLabel.anchor(contentView.topAnchor, left: contentView.leftAnchor, bottom: nil, right: nil, topConstant: 5, leftConstant: 5, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        tempLabel.anchorCenterSuperview()
    }
}
