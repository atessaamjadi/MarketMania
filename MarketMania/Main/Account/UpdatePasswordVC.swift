//
//  UpdatePasswordVC.swift
//  BadgerBytes
//
//  Created by Mitch Alley on 3/16/21.
//

import Firebase

class UpdatePasswordVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    weak var cv: UICollectionView! // this pages collection view
    
    override func loadView() {
        super.loadView()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        cv.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(cv)
        
        NSLayoutConstraint.activate([
                   cv.topAnchor.constraint(equalTo: self.view.topAnchor),
                   cv.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
                   cv.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
                   cv.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
               ])
        self.cv = cv
    }
    
    override func viewDidLoad() {
           super.viewDidLoad()

           self.cv.backgroundColor = .main_background
           self.cv.dataSource = self
           self.cv.delegate = self

            self.cv.register(SimpleTextInputCell.self, forCellWithReuseIdentifier: "SimpleText")
            self.cv.register(SimpleTextCell.self, forCellWithReuseIdentifier: "MyCell")
       }



// everything is public to match public status of protocols they are following
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        if (indexPath.row == 0) {
            // update password
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SimpleText", for: indexPath) as! SimpleTextInputCell
            cell.textInput.isSecureTextEntry = true
            cell.textInput.attributedPlaceholder = NSAttributedString(string: "Old Password", attributes: [.foregroundColor: UIColor.subtitle_label])
            
            cell.accessibilityIdentifier = "old"
            
            return cell
        }
        
        else if (indexPath.row == 1) {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SimpleText", for: indexPath) as! SimpleTextInputCell
            cell.textInput.isSecureTextEntry = true
            cell.textInput.attributedPlaceholder = NSAttributedString(string: "New Password", attributes: [.foregroundColor: UIColor.subtitle_label])
            
            cell.accessibilityIdentifier = "new"
            
            return cell
        }
        
        else if (indexPath.row == 2){
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SimpleText", for: indexPath) as! SimpleTextInputCell
            cell.textInput.isSecureTextEntry = true
            cell.textInput.attributedPlaceholder = NSAttributedString(string: "Confirm New Password", attributes: [.foregroundColor: UIColor.subtitle_label])
            
            cell.accessibilityIdentifier = "confirmNew"
            
            return cell
        }
        
        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath) as! SimpleTextCell
            
            cell.textLabel.text = "Confirm"
            cell.textLabel.textColor = .main_background
            cell.textLabel.textAlignment = .center
            cell.contentView.backgroundColor = .primary_purple
            
            
            cell.accessibilityIdentifier = "confirm"
            
            return cell
        }
    }

    private func processPasswordChange() -> Bool {
        
        let user = Auth.auth().currentUser
        
                
        let oldPassword: SimpleTextInputCell = cv.cellForItem(at: [0,0]) as! SimpleTextInputCell
        let newPassword: SimpleTextInputCell = cv.cellForItem(at: [0,1]) as! SimpleTextInputCell
        let confirmNewPassword: SimpleTextInputCell = cv.cellForItem(at: [0,2]) as! SimpleTextInputCell
        
        if (oldPassword.textInput.text == "" || newPassword.textInput.text == "" ||
                confirmNewPassword.textInput.text == "") {
            return false
        }
        
        else if (newPassword.textInput.text != confirmNewPassword.textInput.text) {
            return false
        }
        
        Auth.auth().signIn(withEmail: (user?.email)!, password: oldPassword.textInput.text!) { authResult, error in
            
            print("password worked")
            
            Auth.auth().currentUser?.updatePassword(to: newPassword.textInput.text!)
            
            // TODO: Handle error cases
        }
        
        return true
    }
    
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if (indexPath.row == 3) {
            print(3)
            
            if (processPasswordChange()) {
                let alert = UIAlertController(title: "Success!", message: "Your password has been successfully changed.", preferredStyle: .alert)
                
                self.present(alert, animated: true, completion: nil)
                
                alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))

                
            } else {
                // send user an error message to try again
                let alert = UIAlertController(title: "Error!", message: "Unable to change password, please try again.", preferredStyle: .alert)
                
                self.present(alert, animated: true, completion: nil)
                
                alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
                
            }
            
        }
            
    }


    public func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.bounds.size.width - 16, height: 40)
    }
    public func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }

    public func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    public func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: 8, left: 8, bottom: 8, right: 8)
    }
}
