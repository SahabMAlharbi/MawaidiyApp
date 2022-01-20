//
//  UpdateMawid.swift
//  Mawaidiy
//
//  Created by Sahab Alharbi on 16/06/1443 AH.
//

import UIKit
import Firebase
class UpdateMawid: UIViewController {
    let firestore = Firestore.firestore()
    var ref: DocumentReference? = nil
    let user = Auth.auth().currentUser?.uid
    @IBOutlet weak var clinicName: UITextField!
    @IBOutlet weak var patientName: UITextField!
    @IBOutlet weak var doctorName: UITextField!
    @IBOutlet weak var descriptio: UITextField!
    @IBOutlet weak var timeTF: UITextField!
    @IBOutlet weak var placeTF: UITextField!
    var mawaid : Mawid?
    var mawid = [Mawid]()
    var mawaidDetails = MawidDetails()
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

    @IBAction func updateDone(_ sender: Any) {
        update(mawaid: mawaid!)
        
       
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    func update(mawaid: Mawid){
        firestore.collection("Mawaid").document(mawaid.id).setData(
                [
                    "clinic Name" : self.clinicName.text!,
                    "patient Name" : self.patientName.text!,
                    "doctor Name" : self.doctorName.text!,
                    "description" : self.descriptio.text!,
                    "time" : self.timeTF.text!,
                    "place" : self.placeTF.text!
               
             ],merge: true
            )
            { error in
                
                if error == nil {
                    self.mawaidDetails.getdata()
                    
                    self.dismiss(animated: true, completion: nil)

                    
                } else{
                    let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                    
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    
                    self.present(alertController, animated: true, completion: nil)
                }
            }
    }
}
