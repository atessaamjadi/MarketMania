//
//  SearchVC.swift
//  MarketMania
//
//  Created by Thor Larson on 3/16/21.
//

import UIKit

class SearchVC: UIViewController, UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate {
    
    //
    // MARK: View Lifecycle
    //
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(hex: "272C37")
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        tableView.register(SearchTableViewCell.self, forCellReuseIdentifier: "searchTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        // self.tableView.register(UINib.init(nibName: "UITableViewCell", bundle: nil), forCellReuseIdentifier: "UITableViewCell")
        
        searchBar.delegate = self
        self.navigationItem.titleView = searchBar
        
        getHighestVolume { response in
            // UI updates are only allowed in main queue
            DispatchQueue.main.async {
                //print("winners", response)
                self.initialStockList = response
                self.tableView.reloadData()
            }
        }
        
        
        setUpViews()
    }
    
    //
    // MARK: Functions
    //
    
    
    
    //
    // MARK: UI Setup
    //

    var activeSearch: Bool = false
    var initialStockList: [Stock] = []
    
    var searchText: String = ""
    var searchStocksArray: [SearchStock] = []
    
    
    var searchBar: UISearchBar = {
        let sb = UISearchBar()
        sb.backgroundColor = .clear
        sb.searchBarStyle = UISearchBar.Style.prominent
        sb.placeholder = "Search..."
        
        //change color of "Search..."
        var searchTextField: UITextField? = sb.value(forKey: "searchField") as? UITextField
           if searchTextField!.responds(to: #selector(getter: UITextField.attributedPlaceholder)) {
            let attributeDict = [NSAttributedString.Key.foregroundColor: UIColor.black]
               searchTextField!.attributedPlaceholder = NSAttributedString(string: "Search", attributes: attributeDict)
           }
        
        sb.sizeToFit()
        sb.isTranslucent = true
        
        searchTextField?.accessibilityIdentifier = "stf"
        
        return sb
    }()
    
    let tableView: UITableView = {
        let tb = UITableView()
        tb.backgroundColor = UIColor(hex: "272C37")
        return tb
        
    }()
    
   
    
    //most popular collection view
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.translatesAutoresizingMaskIntoConstraints = false
        
        
        // register cells
        cv.register(SectorsView.self, forCellWithReuseIdentifier: "sectorsView")
        cv.register(PopularView.self, forCellWithReuseIdentifier: "popularView")
        
        return cv
        
    }()
    
    
    
    // search bar functions
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.becomeFirstResponder()
        searchBar.setShowsCancelButton(true, animated: true)
        tableView.isHidden = false
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchBar.setShowsCancelButton(false, animated: false)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchBar.setShowsCancelButton(false, animated: false)
        activeSearch = false
        
        tableView.isHidden = true
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchBar.setShowsCancelButton(false, animated: false)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("self.searchText = ", self.searchText)
        print("searchText = ", searchText)
        
        // if the
//        if (self.searchText != searchText && searchText.isEmpty == false) {
            print("SEARCH TEXT CHANGED")
            
        // check to make sure string only contains letters
        var allLetters: Bool = true
        
        for chr in searchText {
            if (!(chr >= "a" && chr <= "z") && !(chr >= "A" && chr <= "Z") && chr != "-") {
                allLetters = false
                break
            }
        }
        
        if (allLetters) {
            searchStocks(searchString: searchText) { response in
                DispatchQueue.main.async {
                    self.searchStocksArray = response
                    self.tableView.reloadData()
    
                    print(self.searchStocksArray)
                    
                    self.tableView.reloadData()
    
                }
            }
        } else {
           searchStocksArray = []
        }

        self.searchText = searchText
        
        if searchText.isEmpty {
            activeSearch = false
        } else {
            activeSearch = true
        }
        
        self.tableView.reloadData()
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (activeSearch) {
            return searchStocksArray.count
        } else {
            return initialStockList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchTableViewCell", for: indexPath as IndexPath) as! SearchTableViewCell

        // if the search bar is not empty, meaning stocks from searchStocksArray are listed
        if (activeSearch) {
            
            let stockSymbol = searchStocksArray[indexPath.row].symbol!
            
            getStocks(symbols: [stockSymbol]) { response in
                DispatchQueue.main.async {
                    let stock = response[0]
                    
                    cell.nameLabel.text = stock.symbol
                    cell.currentPriceLabel.text = "$" + String(stock.latestPrice ?? 0.0)
                    cell.percentChangeLabel.text = String(stock.changePercent ?? 0.0) + "%"
                    
                    
                    
                    var str = ""
                    if ((stock.latestPrice ?? 0.0) - (stock.open ?? 0.0) > 0) {
                        str += "+"
                    }
                    str += String((stock.latestPrice ?? 0.0) - (stock.open ?? 0.0))
                    cell.priceChangeLabel.text = str + "$"
                    
                    self.tableView.reloadData()
                    
                }
            }
        // if the search bar is empty, meaning stocks from initialStocksList are listed
        } else {
            let stock = initialStockList[indexPath.row]
            
            cell.nameLabel.text = stock.symbol
            cell.currentPriceLabel.text = "$" + String(stock.latestPrice ?? 0.0)
            cell.percentChangeLabel.text = String(stock.changePercent ?? 0.0) + "%"
            
            var str = ""
            if ((stock.latestPrice ?? 0.0) - (stock.open ?? 0.0) > 0) {
                str += "+"
            }
            str += String((stock.latestPrice ?? 0.0) - (stock.open ?? 0.0))
            cell.priceChangeLabel.text = str + "$"
        }
        
        //make search table view cells black with white text
        cell.backgroundColor = UIColor(hex: "3A3E50")
        cell.textLabel?.textColor = .white
        cell.layer.borderColor = UIColor(hex: "686B75").cgColor
        cell.layer.borderWidth = 0.2
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let stockDetailVC = StockDetailVC()
        
        if (activeSearch) {
            let tappedStockSymbol = searchStocksArray[indexPath.row].symbol!
            
            getStocks(symbols: [tappedStockSymbol]) { response in
                DispatchQueue.main.async {
                    let tappedStock = response[0]
                    
                    stockDetailVC.stock = tappedStock
                    
                    self.navigationController?.pushViewController(stockDetailVC, animated: true)
                    
                    self.tableView.reloadData()
                }
            }
        } else {
            stockDetailVC.stock = initialStockList[indexPath.row]
            self.navigationController?.pushViewController(stockDetailVC, animated: true)
        }
    }
    
    
    func setUpViews() {
        
        view.addSubviews(views: [collectionView, tableView])
        
        collectionView.fillSuperview()
    
        tableView.anchor(view.safeAreaLayoutGuide.topAnchor, left: view.safeAreaLayoutGuide.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.safeAreaLayoutGuide.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        tableView.isHidden = true
        view.bringSubviewToFront(tableView)

    }
}

extension SearchVC: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0 {
            return CGSize(width: collectionView.frame.width, height: collectionView.frame.height/3)
        }
        
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height/2)
        
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "popularView", for: indexPath) as! PopularView
            return cell
        }
        
        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "sectorsView", for: indexPath) as! SectorsView
            cell.searchVC = self
            return cell
        }
       
    }
}

class SearchTableViewCell: UITableViewCell {
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
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
    
    //extra elements seen by expanded cell
    
//    let fullNameLabel: UILabel = {
//        let label = UILabel()
//        label.add(text: "APPLE", font: UIFont(name: "PingFangHK-Regular", size: 15)!, textColor: .black)
//        label.textAlignment = .center
//        return label
//    }()
    
//    let descriptionTextView: UITextView = {
//        let text = UITextView()
//        text.text = "Description of the company Description of the company Description of the company Description of the company Description of the company Description of the company Description of the company Description of the company Description of the company Description of the company Description of the company Description of the company Description of the company Description of the company Description of the company"
//        text.isScrollEnabled = false
//        text.font = UIFont(name: "PingFangHK-Regular", size: 10)
//        text.backgroundColor = .clear
//        text.textColor = .black
//        text.textAlignment = .left
//    
//        
//        return text
//    }()
    
    //TODO: need to figure out how to make this hidden if the cell is collapsed
    
//    let tradeButton: UIButton = {
//        let btn = UIButton(type: .system)
//        btn.add(text: "Trade", font: UIFont(boldWithSize: 20), textColor: .black)
//        btn.layer.borderColor = UIColor.black.cgColor
//        btn.layer.borderWidth = 2
//
//        btn.frame.size.width = 200
//        btn.frame.size.height = 10
//        //btn.addTarget(self, action: #selector(handleTrade), for: .touchUpInside)
//       return btn
//    }()
    
    
    
    func setUpViews() {
        
        contentView.addSubviews(views: [nameLabel, dashLabel, currentPriceLabel, percentChangeLabel, priceChangeLabel /* fullNameLabel descriptionTextView*/])
        
        nameLabel.anchor(contentView.topAnchor, left: contentView.leftAnchor, bottom: nil, right: dashLabel.leftAnchor, topConstant: 20, leftConstant: 10, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        dashLabel.anchor(contentView.topAnchor, left: nameLabel.rightAnchor, bottom: nil, right: currentPriceLabel.leftAnchor, topConstant: 20, leftConstant: 2, bottomConstant: 0, rightConstant: 2, widthConstant: 0, heightConstant: 0)
        
        currentPriceLabel.anchor(contentView.topAnchor, left: dashLabel.rightAnchor, bottom: nil, right: nil, topConstant: 20, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        percentChangeLabel.anchor(contentView.topAnchor, left: nil, bottom: nil, right: contentView.rightAnchor, topConstant: 10, leftConstant: 0, bottomConstant: 5, rightConstant: 10, widthConstant: 0, heightConstant: 0)
        
        priceChangeLabel.anchor(percentChangeLabel.bottomAnchor, left: nil, bottom: contentView.bottomAnchor, right: contentView.rightAnchor, topConstant: 5, leftConstant: 0, bottomConstant: 10, rightConstant: 10, widthConstant: 0, heightConstant: 0)
        
//        fullNameLabel.anchor(priceChangeLabel.bottomAnchor, left: contentView.leftAnchor, bottom: nil, topConstant: 20, leftConstant: 10, bottomConstant: 10, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
//        descriptionTextView.anchor(fullNameLabel.bottomAnchor, left: contentView.leftAnchor, bottom: nil, right: contentView.rightAnchor, topConstant: 0, leftConstant: 10, bottomConstant: 10, rightConstant: 10, widthConstant: 0, heightConstant: 0)
      
//        tradeButton.anchor(nil, left: nil, bottom: contentView.bottomAnchor, right: contentView.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 50, rightConstant: 50, widthConstant: 100, heightConstant: 50)
       
       
    }
}
