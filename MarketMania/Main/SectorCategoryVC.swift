//
//  SectorVC.swift
//  MarketMania
//
//  Created by Atessa Amjadi on 3/25/21.
//

import UIKit

class SectorCategoryVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    var selectedIndex: Int?
    var selectedSector: String?
    var sectorStocks: [Stock] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpViews()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        sectorCategoryLabel.text = selectedSector
        navigationItem.titleView = sectorCategoryLabel
        
        getCollection(type: "sector", collectionName: selectedSector ?? "", completion: {
            response in
            DispatchQueue.main.async {
                self.sectorStocks = response
                self.collectionView.reloadData()
            }
        })
        

    }
    
    let sectorCategoryLabel: UILabel = {
        let label = UILabel()
        label.add(text: "TECH FOR NOW", font: UIFont(name: "Verdana-BoldItalic", size: 20)!, textColor: .black)
        label.textAlignment = .center
        return label
        
    }()
    
    var searchBar: UISearchBar = {
        let sb = UISearchBar()
        sb.searchBarStyle = UISearchBar.Style.prominent
        sb.placeholder = " Search..."
        sb.sizeToFit()
        sb.isTranslucent = false
        sb.backgroundColor = .black
        
        return sb
    }()
    
    //collection view
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        //cv.backgroundColor = .menu_white
        cv.translatesAutoresizingMaskIntoConstraints = false
        
        // register cells
        cv.register(SectorCategoryCell.self, forCellWithReuseIdentifier: "sectorCategoryCell")
        
        return cv
    }()
    

    func setUpViews() {
        
        //view.backgroundColor = .menu_white
        
        view.addSubviews(views: [searchBar, collectionView])
        
        //sectorCategoryLabel is navigation title right now
        
//        sectorCategoryLabel.anchor(view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 10, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        searchBar.anchor(view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        collectionView.anchor(searchBar.bottomAnchor, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, topConstant: 10, leftConstant: 10, bottomConstant: 0, rightConstant: 10, widthConstant: 0, heightConstant: 0)

    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (sectorStocks.count != 0) {
            return sectorStocks.count
        }
        
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "sectorCategoryCell", for: indexPath) as! SectorCategoryCell
        
        guard sectorStocks.count != 0 else {return cell}
        
        let stock = sectorStocks[indexPath.row]
        
        cell.nameLabel.text = stock.symbol
        cell.currentPriceLabel.text = String(stock.latestPrice ?? 0.0)
        cell.percentChangeLabel.text = String(stock.changePercent ?? 0.0)
        cell.priceChangeLabel.text = String((stock.latestPrice ?? 0.0) - (stock.open ?? 0.0))
        
        return cell
    }
    
//    source for selected cell expansion and closure: https://stackoverflow.com/questions/34478329/uicollectionview-enlarge-cell-on-selection
    
    var selectedIndexPath: IndexPath!
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //if a cell has been selected
        if selectedIndexPath != nil {
            if indexPath == selectedIndexPath {
                return CGSize(width: collectionView.frame.size.width, height: collectionView.frame.size.width)
            }
            //size of unselected cell
            else {
                return CGSize(width: collectionView.frame.width, height: collectionView.frame.width/7)
            }
        }
        //if a cell has not been selected
        //size of a unselected cell
        else {
            return CGSize(width: collectionView.frame.width, height: collectionView.frame.width/7)
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //make selected cell back to original size
        if selectedIndexPath != nil && selectedIndexPath == indexPath{
            selectedIndexPath = nil
        }
        //set selectedIndexPath to selected cell index
        else {
            selectedIndexPath = indexPath
        }
            collectionView.reloadData()
    }
}


class SectorCategoryCell: UICollectionViewCell {
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .systemGray5
        
        setUpViews()
    }
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.add(text: "APPL", font: UIFont(name: "PingFangHK-Regular", size: 15)!, textColor: .black)
        label.textAlignment = .center
        return label
    }()
    
    let dashLabel: UILabel = {
        let label = UILabel()
        label.add(text: " - ", font: UIFont(name: "PingFangHK-Regular", size: 15)!, textColor: .black)
        label.textAlignment = .center
        return label
    }()
    
    let currentPriceLabel: UILabel = {
        let label = UILabel()
        label.add(text: "$120.62", font: UIFont(name: "PingFangHK-Regular", size: 15)!, textColor: .black)
        label.textAlignment = .center
        return label
    }()
    
    let percentChangeLabel: UILabel = {
        let label = UILabel()
        label.add(text: "-1.14%", font: UIFont(name: "PingFangHK-Regular", size: 11)!, textColor: .black)
        label.textAlignment = .center
        return label
    }()
    
    let priceChangeLabel: UILabel = {
        let label = UILabel()
        label.add(text: "-$1,025.60", font: UIFont(name: "PingFangHK-Regular", size: 11)!, textColor: .black)
        label.textAlignment = .center
        return label
    }()
    
    
    
    
    func setUpViews() {
        
        contentView.addSubviews(views: [nameLabel, dashLabel,currentPriceLabel, percentChangeLabel,priceChangeLabel])
        
        nameLabel.anchor(contentView.topAnchor, left: contentView.leftAnchor, bottom: nil, right: dashLabel.leftAnchor, topConstant: 20, leftConstant: 10, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        dashLabel.anchor(contentView.topAnchor, left: nameLabel.rightAnchor, bottom: nil, right: currentPriceLabel.leftAnchor, topConstant: 20, leftConstant: 2, bottomConstant: 0, rightConstant: 2, widthConstant: 0, heightConstant: 0)
        
        currentPriceLabel.anchor(contentView.topAnchor, left: dashLabel.rightAnchor, bottom: nil, right: nil, topConstant: 20, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        percentChangeLabel.anchor(contentView.topAnchor, left: nil, bottom: nil, right: contentView.rightAnchor, topConstant: 10, leftConstant: 0, bottomConstant: 5, rightConstant: 10, widthConstant: 0, heightConstant: 0)
        
        priceChangeLabel.anchor(percentChangeLabel.bottomAnchor, left: nil, bottom: nil, right: contentView.rightAnchor, topConstant: 5, leftConstant: 0, bottomConstant: 10, rightConstant: 10, widthConstant: 0, heightConstant: 0)
        
      
       
       
    }
    
    
    
}


    


