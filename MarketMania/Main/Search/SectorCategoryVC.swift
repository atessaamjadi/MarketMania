//
//  SectorVC.swift
//  MarketMania
//
//  Created by Atessa Amjadi on 3/25/21.
//

import UIKit

class SectorCategoryVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {

    var selectedIndex: Int?
    var selectedSector: String = ""
    var sectorStocks: [Stock] = []
    var filtered: [Stock] = []
    var activeSearch: Bool = false
    var searchText: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpViews()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        //commented out for now
        
        //sectorCategoryLabel.text = selectedSector
        sectorCategoryLabel.text = selectedSector
        navigationItem.titleView = sectorCategoryLabel
        
        searchBar.delegate = self
        
        getCollection(type: "sector", collectionName: selectedSector, completion: {
            response in
            DispatchQueue.main.async {
                self.sectorStocks = response
                print("RESP", response)
                self.filtered = self.sectorStocks
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
        cv.register(SectorCategoryCellExpanded.self, forCellWithReuseIdentifier: "sectorCategoryCellExpanded")
        
        
        return cv
    }()
    
    
    // search bar functionalities
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.becomeFirstResponder()
        searchBar.setShowsCancelButton(true, animated: true)
        activeSearch = true
        
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchBar.setShowsCancelButton(false, animated: false)
        activeSearch = false
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchBar.setShowsCancelButton(false, animated: false)
        activeSearch = false
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchBar.setShowsCancelButton(false, animated: false)
        
        activeSearch = true
        
//        print(searchText)
//        getStocks(symbols: [searchText]) { response in
//            DispatchQueue.main.async {
//                self.stocks = response
//                self.tableView.reloadData()
//
//                print(self.stocks[0].companyName! as String)
//                print(self.stocks[0].symbol! as String)
//                print(self.stocks[0].latestPrice! as Float)
//            }
//        }
        
        
    }
    
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchText = searchText
        
        if searchText.isEmpty == false {
            self.filtered = self.sectorStocks.filter { stock in return (stock.symbol!.lowercased().contains(searchText.lowercased()))}
        }
        else {
            self.filtered = self.sectorStocks
        }
        
//        filtered = dummyData.filter({ (text) -> Bool in
//            let tmp: NSString = text as NSString
//            let range = tmp.range(of: searchText, options: NSString.CompareOptions.caseInsensitive)
//            return range.location != NSNotFound
//        })
        
        if (filtered.count == 0) {
            if (searchText.isEmpty == true) {
                activeSearch = false
            }
            else {
                filtered = []
                activeSearch = true
            }
        } else {
            activeSearch = true
        }
        
        self.collectionView.reloadData()
    }
    

    func setUpViews() {
        
        view.addSubviews(views: [searchBar, collectionView])
        
        searchBar.anchor(view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        collectionView.anchor(searchBar.bottomAnchor, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, topConstant: 10, leftConstant: 10, bottomConstant: 0, rightConstant: 10, widthConstant: 0, heightConstant: 0)

    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (activeSearch) {
            return filtered.count
        } else {
            return sectorStocks.count
        }
    }
    
    var selectedIndexPath: IndexPath!
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        //this is for an expanded cell (has extra view elements)
        if selectedIndexPath != nil {
            if selectedIndexPath == indexPath {
                
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "sectorCategoryCellExpanded", for: indexPath) as! SectorCategoryCellExpanded
                
                guard sectorStocks.count != 0 else {return cell}
                
                let stock = sectorStocks[indexPath.row]
                
                cell.nameLabel.text = stock.symbol
                cell.currentPriceLabel.text = String(stock.latestPrice ?? 0.0)
                cell.percentChangeLabel.text = String(stock.changePercent ?? 0.0)
                cell.priceChangeLabel.text = String((stock.latestPrice ?? 0.0) - (stock.open ?? 0.0))
                
                return cell
                
            }
            
            else {
                //this is for a collapsed cell
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "sectorCategoryCell", for: indexPath) as! SectorCategoryCell
                
                guard sectorStocks.count != 0 else {return cell}
                
                let stock = sectorStocks[indexPath.row]
                
                cell.nameLabel.text = stock.symbol
                cell.currentPriceLabel.text = String(stock.latestPrice ?? 0.0)
                cell.percentChangeLabel.text = String(stock.changePercent ?? 0.0)
                cell.priceChangeLabel.text = String((stock.latestPrice ?? 0.0) - (stock.open ?? 0.0))
                
                return cell
            }
        }
        
        //this is for a collapsed cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "sectorCategoryCell", for: indexPath) as! SectorCategoryCell
        
        guard filtered.count != 0 else {return cell}
    
        let stock = filtered[indexPath.row]

        cell.nameLabel.text = stock.symbol
        cell.currentPriceLabel.text = "$" + String(stock.latestPrice ?? 0.0)
        cell.percentChangeLabel.text = String(stock.changePercent ?? 0.0) + "%"
        
        var str = ""
        if ((stock.latestPrice ?? 0.0) - (stock.open ?? 0.0) > 0) {
            str += "+"
        }
        str += String((stock.latestPrice ?? 0.0) - (stock.open ?? 0.0))
        cell.priceChangeLabel.text = str + "$"
                
         
        return cell
    }
    
//    source for selected cell expansion and closure: https://stackoverflow.com/questions/34478329/uicollectionview-enlarge-cell-on-selection
    
   
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //if a cell has been selected
        if selectedIndexPath != nil {
            if indexPath == selectedIndexPath {
                return CGSize(width: collectionView.frame.size.width, height: collectionView.frame.size.width/1.25)
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
    
    //elements seen by unexpanded cell
    
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
        
        contentView.addSubviews(views: [nameLabel, dashLabel, currentPriceLabel, percentChangeLabel, priceChangeLabel])
        
        nameLabel.anchor(contentView.topAnchor, left: contentView.leftAnchor, bottom: nil, right: dashLabel.leftAnchor, topConstant: 20, leftConstant: 10, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        dashLabel.anchor(contentView.topAnchor, left: nameLabel.rightAnchor, bottom: nil, right: currentPriceLabel.leftAnchor, topConstant: 20, leftConstant: 2, bottomConstant: 0, rightConstant: 2, widthConstant: 0, heightConstant: 0)
        
        currentPriceLabel.anchor(contentView.topAnchor, left: dashLabel.rightAnchor, bottom: nil, right: nil, topConstant: 20, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        percentChangeLabel.anchor(contentView.topAnchor, left: nil, bottom: nil, right: contentView.rightAnchor, topConstant: 10, leftConstant: 0, bottomConstant: 5, rightConstant: 10, widthConstant: 0, heightConstant: 0)
        
        priceChangeLabel.anchor(percentChangeLabel.bottomAnchor, left: nil, bottom: nil, right: contentView.rightAnchor, topConstant: 5, leftConstant: 0, bottomConstant: 10, rightConstant: 10, widthConstant: 0, heightConstant: 0)
       
    }
}

class SectorCategoryCellExpanded: UICollectionViewCell {
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .systemGray5
        
        setUpViews()
    }
    
    //elements also seen in unexpanded cell
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
    
    //extra elements seen by expanded cell
    
    let fullNameLabel: UILabel = {
        let label = UILabel()
        label.add(text: "APPLE", font: UIFont(name: "PingFangHK-Regular", size: 15)!, textColor: .black)
        label.textAlignment = .center
        return label
    }()
    
    let descriptionTextView: UITextView = {
        let text = UITextView()
        text.text = "Description of the company Description of the company Description of the company Description of the company Description of the company Description of the company Description of the company Description of the company Description of the company Description of the company Description of the company Description of the company Description of the company Description of the company Description of the company"
        text.isScrollEnabled = false
        text.font = UIFont(name: "PingFangHK-Regular", size: 10)
        text.backgroundColor = .clear
        text.textColor = .black
        text.textAlignment = .left
    
        
        return text
    }()
    
    let tradeButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.add(text: "Trade", font: UIFont(boldWithSize: 20), textColor: .black)
        btn.layer.borderColor = UIColor.black.cgColor
        btn.layer.borderWidth = 0.5

//        btn.frame.size.width = 200
//        btn.frame.size.height = 10
        //btn.addTarget(self, action: #selector(handleTrade), for: .touchUpInside)
       return btn
    }()
    
    let watchListButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.add(text: "Add to watchlist", font: UIFont(boldWithSize: 20), textColor: .black)
        btn.layer.borderColor = UIColor.black.cgColor
        btn.layer.borderWidth = 0.5

//        btn.frame.size.width = 200
//        btn.frame.size.height = 10
        //btn.addTarget(self, action: #selector(handleTrade), for: .touchUpInside)
       return btn
    }()
    
    
    
    func setUpViews() {
        
        contentView.addSubviews(views: [nameLabel, dashLabel, currentPriceLabel, percentChangeLabel, priceChangeLabel, fullNameLabel, descriptionTextView, tradeButton, watchListButton])
        
        nameLabel.anchor(contentView.topAnchor, left: contentView.leftAnchor, bottom: nil, right: dashLabel.leftAnchor, topConstant: 20, leftConstant: 10, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        dashLabel.anchor(contentView.topAnchor, left: nameLabel.rightAnchor, bottom: nil, right: currentPriceLabel.leftAnchor, topConstant: 20, leftConstant: 2, bottomConstant: 0, rightConstant: 2, widthConstant: 0, heightConstant: 0)
        
        currentPriceLabel.anchor(contentView.topAnchor, left: dashLabel.rightAnchor, bottom: nil, right: nil, topConstant: 20, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        percentChangeLabel.anchor(contentView.topAnchor, left: nil, bottom: nil, right: contentView.rightAnchor, topConstant: 10, leftConstant: 0, bottomConstant: 5, rightConstant: 10, widthConstant: 0, heightConstant: 0)
        
        priceChangeLabel.anchor(percentChangeLabel.bottomAnchor, left: nil, bottom: nil, right: contentView.rightAnchor, topConstant: 5, leftConstant: 0, bottomConstant: 10, rightConstant: 10, widthConstant: 0, heightConstant: 0)
        
        fullNameLabel.anchor(nil, left: contentView.leftAnchor, bottom: descriptionTextView.topAnchor, topConstant: 0, leftConstant: 10, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        descriptionTextView.anchor(contentView.topAnchor, left: contentView.leftAnchor, bottom: nil, right: contentView.rightAnchor, topConstant: contentView.frame.height/3, leftConstant: 10, bottomConstant: 50, rightConstant: 10, widthConstant: 0, heightConstant: 0)
      
        watchListButton.anchor(descriptionTextView.bottomAnchor, left: tradeButton.rightAnchor, bottom: nil, right: contentView.rightAnchor, topConstant: 20, leftConstant: 20, bottomConstant: 50, rightConstant: 50, widthConstant: 100, heightConstant: 0)
       
        tradeButton.anchor(descriptionTextView.bottomAnchor, left: contentView.leftAnchor, bottom: nil, right: watchListButton.leftAnchor, topConstant: 20, leftConstant: 50, bottomConstant: 50, rightConstant: 20, widthConstant: 100, heightConstant: 0)

        
       
    }
    
    
    
}

    


