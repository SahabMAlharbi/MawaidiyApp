//
//  ProfileViewController.swift
//  Mawaidiy
//
//  Created by Sahab Alharbi on 29/05/1443 AH.
//

import UIKit
import Firebase

class ProfileViewController: UIViewController {

    @IBOutlet weak var pName: UILabel!
    @IBOutlet weak var idnumber: UILabel!
    var users = UsersViewController()
    let firestore = Firestore.firestore()
    let userID = Auth.auth().currentUser?.uid
    override func viewDidLoad() {
        super.viewDidLoad()

        DispatchQueue.global(qos: .userInitiated).async {
            DispatchQueue.main.async {
                self.firestore.collection("Users")
                    .whereField("userID", isEqualTo: self.userID as Any)
                    .getDocuments { querySnapshot, error in
                        if let error = error{
                            print("wrong read!!")
                            print(error.localizedDescription)
                        }else {
                            guard querySnapshot != nil else{return}
                            for document in querySnapshot!.documents{
                                let data = document.data()
                                print(data["name"] as? String ?? "")
                                print(data["ID Number"] as? String ?? "")
                                self.pName.text = data["name"] as? String ?? ""
                                self.idnumber.text = data["ID Number"] as? String ?? ""
                                
                            }
                        }
                    }
            }
        }
        // Do any additional setup after loading the view.
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
