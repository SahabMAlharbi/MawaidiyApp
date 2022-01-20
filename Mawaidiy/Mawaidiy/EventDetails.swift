//
//  EventDetails.swift
//  Mawaidiy
//
//  Created by Sahab Alharbi on 14/06/1443 AH.
//

import UIKit
import Firebase
class EventDetails: UIViewController {
    let firestore = Firestore.firestore()
    let user = Auth.auth().currentUser?.uid
    @IBOutlet weak var eventName: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var notes: UILabel!
    @IBOutlet weak var endDate: UILabel!
    var events : Events?
    var eventss = [Events]()

   
   
    @IBOutlet weak var eventV: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        DispatchQueue.global(qos: .userInitiated).async {
            DispatchQueue.main.async {
                self.firestore.collection("Events")
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
                                self.eventName.text = data["event Name"] as? String ?? ""
                                self.date.text = data["start date"] as? String ?? ""
                                self.notes.text = data["notes"] as? String ?? ""
                                self.endDate.text = data["end date"] as? String ?? ""

                            }
                        }
                    }
            }
        }
        // Do any additional setup after loading the view.
        eventV.layer.cornerRadius = 10
    }
    
    @IBAction func deleteEvent(_ sender: Any) {
        deleteData(event: events!)
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "tabbar") as! TabBar
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    
    
      func deleteData(event: Events) {
          firestore.collection("Events").document(event.id).delete { error in
              if error == nil {
                  DispatchQueue.main.async {
                        self.eventss.removeAll { event in
                        return event.id == event.id
                      }
                  }
                  
                  
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
