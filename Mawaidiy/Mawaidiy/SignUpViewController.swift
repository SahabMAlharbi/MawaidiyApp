//
//  SignUpViewController.swift
//  Mawaidiy
//
//  Created by Sahab Alharbi on 30/05/1443 AH.
//

import UIKit
import Firebase

class SignUpViewController: UIViewController {
    let firestore = Firestore.firestore()
    let userID = Auth.auth().currentUser?.uid
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var repasswordTF: UITextField!
    @IBOutlet weak var ageTF: UITextField!
    @IBOutlet weak var iDNumberTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func signUpButton(_ sender: Any) {
        if emailTF.text == "" || nameTF.text == "" || iDNumberTF.text == "" {
            let alertController = UIAlertController(title: "Error", message: "Please enter your name and ID Number and email and password", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            present(alertController, animated: true, completion: nil)
            
        } else {
            firestore.collection("Users").document(nameTF.text!).setData(
                [
                "name" : nameTF.text!,
                "email" : emailTF.text!,
                "age" : ageTF.text!,
                "ID Number" : iDNumberTF.text!,
                "userID" :userID
                

             ]
            )
            { error in
                
                if error == nil {
                    print("You have successfully signed up")
                    
                    
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
        

    }
   
}
