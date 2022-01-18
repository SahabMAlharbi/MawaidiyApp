//
//  NewMawidViewController.swift
//  Mawaidiy
//
//  Created by Sahab Alharbi on 02/06/1443 AH.
//

import UIKit
import Firebase

class NewMawidViewController: UIViewController {

    var ref: DocumentReference? = nil
    let firestore = Firestore.firestore()
    let userID = Auth.auth().currentUser?.uid
    @IBOutlet weak var clinicName: UITextField!
    
    @IBOutlet weak var patientName: UITextField!
    @IBOutlet weak var doctorName: UITextField!
    @IBOutlet weak var descriptio: UITextField!
    @IBOutlet weak var timeTF: UITextField!
    @IBOutlet weak var placeTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
        // Do any additional setup after loading the view.
    }
    
    @IBAction func saveNewMawid(_ sender: Any) {
        let ref = firestore.collection("Mawaid").document()
        // ref is a DocumentReference
        let docid = ref.documentID
        print(docid)
        // id contains the random ID
        ref.setData(
            [
                "clinic Name" : self.clinicName.text!,
                "patient Name" : self.patientName.text!,
                "doctor Name" : self.doctorName.text!,
                "description" : self.descriptio.text!,
                "time" : self.timeTF.text!,
                "place" : self.placeTF.text!,
                "userid" : self.userID,
                "mawidID" : docid
           
            

         ]
        )
        { error in
            
            if error == nil {
                print("You have successfully make a new mawid")
                
                
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "tabbar") as! TabBar
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true, completion: nil)
                
            } else{
                let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(defaultAction)
                
                self.present(alertController, animated: true, completion: nil)
            }
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
