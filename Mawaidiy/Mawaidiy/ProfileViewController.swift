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
    var users = UsersViewController()
    let firestore = Firestore.firestore()
    let user = Auth.auth().currentUser?.uid
    override func viewDidLoad() {
        super.viewDidLoad()

        DispatchQueue.global(qos: .userInitiated).async {
            DispatchQueue.main.async {
                self.firestore.collection("Users")
                    .whereField("userid", isEqualTo: self.user as Any)
                    .getDocuments { querySnapshot, error in
                        if let error = error{
                            print("wrong read!!")
                            print(error.localizedDescription)
                        }else {
                            guard querySnapshot != nil else{return}
                            for document in querySnapshot!.documents{
                                
                                let data = document.data()
                                print(data)
                                self.pName.text = data["name"] as? String ?? ""
                                self.idnumber.text = data["ID Number"] as? String ?? ""
                                self.phoneN.text = data["Phone Number"] as? String ?? ""
                                self.ageL.text = data["age"] as? String ?? ""
                                self.emailL.text = data["email"] as? String ?? ""
                                
                            }
                        }
                    }
            }
        }
        // Do any additional setup after loading the view.
        let gesture = UITapGestureRecognizer(target: self, action: #selector(userTappedOnLink))
        // if labelView is not set userInteractionEnabled, you must do so
        mawidL.isUserInteractionEnabled = true
        mawidL.addGestureRecognizer(gesture)
    }
    
    @objc func userTappedOnLink() {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "tabbar") as! TabBar
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


//  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
