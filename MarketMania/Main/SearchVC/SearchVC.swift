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
        
        self.navigationController?.navigationBar.barTintColor = .red

        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
        tableView.delegate = self
        tableView.dataSource = self
        // self.tableView.register(UINib.init(nibName: "UITableViewCell", bundle: nil), forCellReuseIdentifier: "UITableViewCell")
        
        searchBar.delegate = self
        self.navigationItem.titleView = searchBar
        
        
        setUpViews()
    }
    
    //
    // MARK: Functions
    //
    
    
    
    //
    // MARK: UI Setup
    //

    
    var dummyData = ["A", "AB", "ABC", "ABCD"]
    var activeSearch: Bool = false
    var filtered: [String] = []
    
    
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
        activeSearch = true
        
        tableView.isHidden = false
        
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
        
        tableView.isHidden = true
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchBar.setShowsCancelButton(false, animated: false)
        
        activeSearch = false
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText.isEmpty == false {
            filtered = dummyData.filter { name in return name.lowercased().contains(searchText.lowercased())}
        }
        else {
            filtered = dummyData
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
        
        self.tableView.reloadData()
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (activeSearch) {
            return filtered.count
        } else {
            return dummyData.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath as IndexPath)
        if (activeSearch) {
            cell.textLabel?.text = filtered[indexPath.row]
        } else {
            cell.textLabel?.text = dummyData[indexPath.row]
        }
        
        //make search table view cells black with white text
        cell.backgroundColor = UIColor(hex: "3A3E50")
        cell.textLabel?.textColor = .white
        cell.layer.borderColor = UIColor(hex: "686B75").cgColor
        cell.layer.borderWidth = 0.2
        
        return cell
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
            return cell
        }
       
    }
    
//    //allows each sector cell change view to it's category collection view (SectorCategoryVC)
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        if collectionView == collectionView2.self {
//            let controller = SectorCategoryVC()
//            controller.selectedIndex = indexPath.row
//            controller.selectedSector = sectorLabels[indexPath.row]
//            self.navigationController?.pushViewController(controller, animated: true)
//        }
//    }
}



