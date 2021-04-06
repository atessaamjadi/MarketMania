//
//  SectorsView.swift
//  MarketMania
//
//  Created by Atessa Amjadi on 4/4/21.
//

import UIKit

class SectorsView: UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var sectorLabels: [String] = []
    
    var searchVC: SearchVC?
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        collectionView2.delegate = self
        collectionView2.dataSource = self
        
        // fill sector labels
        sectorLabels = getSectorLabels()
        
        setUpViews()
    }
    
    let sectorsLabel: UILabel = {
        let label = UILabel()
        label.add(text: "Sectors", font: UIFont(name: "PingFangHK-Medium", size: 15)!, textColor: .white)
        label.textAlignment = .center
        return label
    }()
    
    //sectors collection view
    let collectionView2: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        //cv.backgroundColor = .menu_white
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = .clear
        // register cells
        cv.register(sectorCell.self, forCellWithReuseIdentifier: "sectorCell")
        return cv
    }()
    
    func getSectorLabels() -> [String] {
        let url = Bundle.main.url(forResource: "Stock_Sectors", withExtension: "json")
        
        guard let jsonData = url else {return ["Error retrieving JSON data"]}
        guard let data = try? Data(contentsOf: jsonData) else {return["Error transforming json"]}
        guard let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any]
            else {return["Error serializing JSON object"]}
        
        var ret: [String] = []
        let sectors = json["sectors"] as? [[String: Any]]
        for sector in sectors as? [[String: String]] ?? [["name": "error"]]{
            if let name = sector["name"] {
                ret.append(name)
                //print(name)
            }
        }
        
        return ret
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(sectorLabels.count != 0) {
            return sectorLabels.count
        }
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if (sectorLabels.count != 0) {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "sectorCell", for: indexPath) as! sectorCell
            cell.sectorLabel.text = sectorLabels[indexPath.row]
            return cell
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "sectorCell", for: indexPath) as! sectorCell
        cell.sectorLabel.text = sectorLabels[indexPath.row]
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.width/3)-10, height: collectionView.frame.width/3)
    }
    
    
    
    func setUpViews(){
        
        contentView.addSubviews(views: [sectorsLabel, collectionView2])
        
        
        sectorsLabel.anchor(contentView.safeAreaLayoutGuide.topAnchor, left: contentView.leftAnchor, bottom: collectionView2.topAnchor, right: nil, topConstant: 20, leftConstant: 10, bottomConstant: 5, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        collectionView2.anchor(sectorsLabel.bottomAnchor, left: contentView.leftAnchor, bottom: contentView.safeAreaLayoutGuide.bottomAnchor, right: contentView.rightAnchor, topConstant: 0, leftConstant: 10, bottomConstant: 0, rightConstant: 10, widthConstant: 0, heightConstant: 0)
        
    }
    
    //allows each sector cell change view to it's category collection view
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sectorCategoryVC = SectorCategoryVC()
        searchVC?.navigationController?.pushViewController(sectorCategoryVC, animated: true)
    }
    
    
}


class sectorCell: UICollectionViewCell {
    
    let sectorLabel: UILabel = {
        let label = UILabel()
        label.add(text: "Sector", font: UIFont(boldWithSize: 12), textColor: .white)
        label.textAlignment = .center
        label.numberOfLines = 5
        return label
    }()
    
    //add image
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
                
        backgroundColor = UIColor(hex: "3A3E50")
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 5
        
        setUpViews()
        
    }

    func setUpViews() {
        
        contentView.addSubview(sectorLabel)
        sectorLabel.anchor(contentView.topAnchor, left: contentView.leftAnchor, bottom: contentView.bottomAnchor, right: contentView.rightAnchor, topConstant: 10, leftConstant: 10, bottomConstant: 0, rightConstant: 10, widthConstant: 0, heightConstant: 0)
    }
}
