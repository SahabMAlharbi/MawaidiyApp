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
    let user = Auth.auth().currentUser?.uid
    var users = [Users]()
    var mawaid = [Mawid]()
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
//        func loadMawaid(){
//            firestore.collection("Mawaid").addSnapshotListener { (QuerySnapshot, error) in
//                guard let document = QuerySnapshot?.documents else{
//                    return
//                }
//                self.mawaid = document.map({ (QueryDocumentSnapshot) -> Mawid in
//                    let data = QueryDocumentSnapshot.data()
//        //                let id = data["userID"] as? String ?? ""
//                    let clinicName = data["clinic Name"] as? String ?? "NO VALUE"
//                    let patientName = data["patient Name"] as? String ?? "NO VALUE"
//                    let description = data["description"] as? String ?? "NO VALUE"
//                    let time = data["time"] as? String ?? "NO VALUE"
//                    let place = data["place"] as? String ?? "NO VALUE"
//                    return Mawid(clinicName: clinicName, patientName: patientName,description: description,time: time, place: place)
//                })
//            }
//        }

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
struct Mawid {
    var clinicName : String
    var patientName : String
    var description : String
    var time : String
    var place : String
}
struct Events {
    var eventName : String
    var startDate: Date
    var dateString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, dd 'of' MMMM"
        return formatter.string(from: startDate)
    }
    var endDate : Date
    var datestring: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, dd 'of' MMMM"
        return formatter.string(from: startDate)
    }
    var notes : String
}

