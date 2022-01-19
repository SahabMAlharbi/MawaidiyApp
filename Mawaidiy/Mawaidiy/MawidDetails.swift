//
//  MawidDetails.swift
//  Mawaidiy
//
//  Created by Sahab Alharbi on 03/06/1443 AH.
//

import UIKit
import Firebase

class MawidDetails: UIViewController {
    let firestore = Firestore.firestore()
    var ref: DocumentReference? = nil
    let user = Auth.auth().currentUser?.uid
    @IBOutlet weak var clinicL: UILabel!
    @IBOutlet weak var patientNameL: UILabel!
    @IBOutlet weak var doctorNameL: UILabel!
    @IBOutlet weak var descriptionL: UILabel!
    @IBOutlet weak var timeL: UILabel!
    @IBOutlet weak var placeL: UILabel!
    
    @IBOutlet weak var mawidV: UIView!
    var mawaid : Mawid?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        DispatchQueue.global(qos: .userInitiated).async {
            DispatchQueue.main.async {
                self.firestore.collection("Mawaid")
                    .whereField("userid", isEqualTo: self.user)
                    .getDocuments { querySnapshot, error in
                        if let error = error{
                            print("wrong read!!")
                            print(error.localizedDescription)
                        }else {
                            guard querySnapshot != nil else{return}
                            for document in querySnapshot!.documents{
                                
                                let data = document.data()
                                print(data)
                                self.clinicL.text = data["clinic Name"] as? String ?? ""
                                self.patientNameL.text = data["patient Name"] as? String ?? ""
                                self.doctorNameL.text = data["doctor Name"] as? String ?? ""
                                self.descriptionL.text = data["description"] as? String ?? ""
                                self.timeL.text = data["time"] as? String ?? ""
                                self.placeL.text = data["place"] as? String ?? ""

                            }
                        }
                    }
            }
        }
        mawidV.layer.cornerRadius = 10
      

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
