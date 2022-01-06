//
//  UsersViewController.swift
//  Mawaidiy
//
//  Created by Sahab Alharbi on 30/05/1443 AH.
//

import UIKit
import Firebase

class UsersViewController: UIViewController {

    let firestore = Firestore.firestore()
    let userID = Auth.auth().currentUser?.uid
    var users = [Users]()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    func loadData(){
        firestore.collection("Users").addSnapshotListener { (QuerySnapshot, error) in
            guard let document = QuerySnapshot?.documents else{
                return
            }
            self.users = document.map({ (QueryDocumentSnapshot) -> Users in
                let data = QueryDocumentSnapshot.data()
//                let id = data["userID"] as? String ?? ""
                let name = data["name"] as? String ?? "NO VALUE"
                let email = data["email"] as? String ?? "NO VALUE"
                let age = data["age"] as? String ?? "NO VALUE"
                let idnumber = data["ID Number"] as? String ?? "NO VALUE"
                let phoneN = data["Phone Number"] as? String ?? "NO VALUE"
                return Users(name: name, email: email,age: age,idnumber: idnumber, phoneN: phoneN)
            })
        }
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
struct Users {
//    var id : String = UUID().uuidString
    var name : String
    var email : String
    var age : String
    var idnumber : String
    var phoneN : String
}
