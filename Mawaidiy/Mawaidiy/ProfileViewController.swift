//
//  ProfileViewController.swift
//  Mawaidiy
//
//  Created by Sahab Alharbi on 29/05/1443 AH.
//

import UIKit
import Firebase

class ProfileViewController: UIViewController {

    @IBOutlet weak var emailL: UILabel!
    @IBOutlet weak var ageL: UILabel!
    @IBOutlet weak var phoneN: UILabel!
    @IBOutlet weak var pName: UILabel!
    @IBOutlet weak var idnumber: UILabel!
    @IBOutlet weak var mawidL: UILabel!
    let firestore = Firestore.firestore()
    let user = Auth.auth().currentUser?.uid
    override func viewDidLoad() {
        super.viewDidLoad()
            DispatchQueue.main.async {
                self.firestore.collection("Users")
                    .whereField("userID", isEqualTo: self.user )
                    .getDocuments { querySnapshot, error in
                        if let error = error{
                            print("wrong read!!")
                            print(error.localizedDescription)
                        }else {
                            guard querySnapshot != nil else{return}
                            

                            for document in querySnapshot!.documents{
                                print("----------------------------")
                                let data = document.data()
                                print(data)
                                print("data")

                                self.pName.text = data["name"] as? String ?? ""
                                self.emailL.text = data["email"] as? String ?? ""
                                self.ageL.text = data["age"] as? String ?? ""
                                self.idnumber.text = data["ID Number"] as? String ?? ""
                                self.phoneN.text = data["Phone Number"] as? String ?? ""
                                
                               
                                
                            }
                        }
                    }
            }
        
        mawidL.layer.cornerRadius = 10
        ageL.layer.cornerRadius = 10
        ageL.layer.masksToBounds = true
        pName.layer.cornerRadius = 10
        pName.layer.masksToBounds = true
        phoneN.layer.cornerRadius = 10
        phoneN.layer.masksToBounds = true
        idnumber.layer.cornerRadius = 10
        idnumber.layer.masksToBounds = true
        emailL.layer.cornerRadius = 10
        emailL.layer.masksToBounds = true
        // Do any additional setup after loading the view.
        let gesture = UITapGestureRecognizer(target: self, action: #selector(userTappedOnLink))
        // if labelView is not set userInteractionEnabled, you must do so
        mawidL.isUserInteractionEnabled = true
        mawidL.addGestureRecognizer(gesture)
    }
    
    
    @IBAction func signOut(_ sender: Any) {
        
            
            let LoginViewController = SignInViewController()
            let alert = UIAlertController(title: nil, message: "Are you sure you want to Sign Out", preferredStyle: .alert)
            let action = UIAlertAction(title: "Sign Out", style: .destructive) {_ in
                do {
                    try Auth.auth().signOut()
                    LoginViewController.modalPresentationStyle = .fullScreen
                    self.present(LoginViewController, animated: true, completion: nil)
                } catch {
                    print(error.localizedDescription)
                }
            }
            
            alert.addAction(action)
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            present(alert, animated: true, completion: nil)
            
        
        
    }
    
    @objc func userTappedOnLink() {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "tabbar") as! TabBar
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
}


//  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
