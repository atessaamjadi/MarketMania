//
//  HomeVC.swift
//  MarketMania
//
//  Created by Thor Larson on 3/16/21.
//

import UIKit

class HomeVC: UIViewController {
    
    //
    // MARK: View Lifecycle
    //
    
    var winners: [Stock] = []
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        setUpViews()
        
        collectionView1.delegate = self
        collectionView1.dataSource = self
        
        collectionView2.delegate = self
        collectionView2.dataSource = self
        
        // run async function that reloads view once data is fetched
        
        //getStocks(symbols: ["AAPL", "MO"])
    }
    
    //hide the navigation bar with "Home" title
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    //
    // MARK: Functions
    //
    
    //
    // MARK: UI Setup
    //
    
    //scroll view stuff is commented out depending if we want to implement it or just resize stuff
    
//    let scrollView: UIScrollView = {
//        let sv = UIScrollView()
//        sv.translatesAutoresizingMaskIntoConstraints = false
//        //sv.backgroundColor = .white
//
//        //make scroll view scollable
//        sv.contentSize = CGSize(width: sv.bounds.width, height: 800)
//        return sv
//    }()
    
    let welcomeLabel: UILabel = {
        let label = UILabel()
        label.add(text: "Welcome back " + (globalCurrentUser?.firstName ?? ""), font: UIFont.boldSystemFont(ofSize: 25.0), textColor: .darkGray)
        label.textAlignment = .center
        return label
        
    }()
    
    let tempSarcasticLabel: UILabel = {
        let label = UILabel()
        label.add(text: "Ready to lose more $ ?", font: UIFont(name: "PingFangHK-Regular", size: 15)!, textColor: .gray)
        label.textAlignment = .center
        return label
    }()
    
    let topMovesLabel: UILabel = {
        let label = UILabel()
        label.add(text: "Top Moves", font: UIFont(name: "PingFangHK-Regular", size: 15)!, textColor: .gray)
        label.textAlignment = .center
        return label
    }()
    
    //top moves collection view
    let collectionView1: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .menu_white
        cv.translatesAutoresizingMaskIntoConstraints = false
        
        // register cells
        cv.register(MoverCell.self, forCellWithReuseIdentifier: "mover")
        return cv
    }()
    
    
    let watchListLabel: UILabel = {
        let label = UILabel()
        label.add(text: "Watchlist", font: UIFont(name: "PingFangHK-Regular", size: 15)!, textColor: .gray)
        label.textAlignment = .center
        return label
    }()
    
    //watchlist collection view
    let collectionView2: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .menu_white
        cv.translatesAutoresizingMaskIntoConstraints = false
        
        // register cells
        cv.register(watchListCell.self, forCellWithReuseIdentifier: "watchListCell")
        return cv
    }()
    

    func setUpViews() {
        
//        view.addSubview(scrollView)
//
//        scrollView.addSubviews(views: [welcomeLabel, topMovesLabel, collectionView1, watchListLabel ,collectionView2])
//
//        self.scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true;
//       self.scrollView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 20).isActive = true;
//       self.scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20).isActive = true;
//       self.scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -20).isActive = true;
        
        
//        VIEWS WITHOUT SCROLL VIEW

        view.addSubviews(views: [tempSarcasticLabel, welcomeLabel, topMovesLabel, collectionView1, watchListLabel, collectionView2])

        welcomeLabel.anchor(view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: nil, right: nil, topConstant: 30, leftConstant: 10, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        tempSarcasticLabel.anchor(welcomeLabel.bottomAnchor, left: view.leftAnchor, bottom: nil, right: nil, topConstant: 10, leftConstant: 20, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)

        topMovesLabel.anchor(nil, left: view.leftAnchor, bottom: collectionView1.topAnchor, right: nil, topConstant: 0, leftConstant: 10, bottomConstant: 5, rightConstant: 0, widthConstant: 0, heightConstant: 0)

        //make the collection view only the height of one cell
        collectionView1.heightAnchor.constraint(equalTo: collectionView1.widthAnchor, multiplier: 0.4).isActive = true

        collectionView1.anchor(view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: view.frame.height/2.5, leftConstant: 10, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)

        watchListLabel.anchor(collectionView1.bottomAnchor, left: view.leftAnchor, bottom: collectionView2.topAnchor, right: nil, topConstant: 20, leftConstant: 10, bottomConstant: 5, rightConstant: 20, widthConstant: 0, heightConstant: 0)

        collectionView2.anchor(watchListLabel.bottomAnchor, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 10, bottomConstant: 0, rightConstant: 10, widthConstant: 0, heightConstant: 0)

    }
}

extension HomeVC: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == collectionView1.self {
            return CGSize(width: collectionView.frame.width/2.5, height: collectionView.frame.width/2.5)
        }
        
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height/3)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == collectionView1.self {
            
            //**** Commented out for now to see UI
    //        print(winners.count)
    //        return winners.count
            
            return 10
        }
        
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == collectionView1.self {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "mover", for: indexPath) as! MoverCell
            return cell
        }
        
        //**** Commented out for now to see UI
        //let stock = winners[indexPath.row]
        
//        cell.tickerLabel.text = stock.symbol
//        cell.nameLabel.text = stock.companyName
//        cell.moveLabel.text = String((stock.changePercent ?? 0.0))
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "watchListCell", for: indexPath) as! watchListCell
        return cell
       
    }
}

class MoverCell: UICollectionViewCell {
    
    let tickerLabel: UILabel = {
        let label = UILabel()
        label.text = "PlaceHolder"
        return label
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "subtext placeholder"
        return label
    }()
    
    let moveLabel: UILabel = {
        let label = UILabel()
        label.text = "move %"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        backgroundColor = .systemBlue
        
        let stack: UIStackView = setUpViews()
        self.contentView.addSubview(stack)
        
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            stack.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            stack.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            stack.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor)
        ])
        
        self.contentView.layer.cornerRadius = 5
    }
    
    func setUpViews() -> UIStackView {
        let stack = UIStackView()
        
        stack.axis = .vertical
        stack.translatesAutoresizingMaskIntoConstraints = false
        
//        stack.addArrangedSubview(tickerLabel)
//        stack.addArrangedSubview(nameLabel)
//        stack.addArrangedSubview(moveLabel)
        
        return stack
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//cells for watchlist
class watchListCell: UICollectionViewCell {

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .systemTeal
        
        setUpViews()
    }
    
    let tempLabel: UILabel = {
        let label = UILabel()
        label.add(text: "testing", font: UIFont(name: "PingFangHK-Regular", size: 15)!, textColor: .black)
        label.textAlignment = .center
        return label
    }()
    
    func setUpViews() {
        
//        contentView.addSubview(tempLabel)
        
//        tempLabel.anchor(contentView.topAnchor, left: contentView.leftAnchor, bottom: nil, right: nil, topConstant: 5, leftConstant: 5, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
      
       
       
    }
}





