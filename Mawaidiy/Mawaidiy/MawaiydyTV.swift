//
//  MawaiydyTV.swift
//  Mawaidiy
//
//  Created by Sahab Alharbi on 29/05/1443 AH.
//

import UIKit
import Firebase


class MawaiydyTV: UIViewController, UITableViewDataSource, UITableViewDelegate {

    let firestore = Firestore.firestore()
    let user = Auth.auth().currentUser?.uid
    var mawaid = [Mawid]()
    @IBOutlet weak var mawaiydyTV: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        mawaiydyTV.delegate = self
        mawaiydyTV.dataSource = self
        loadmawaid()
//        mawaiydyTV.reloadData()
//        lodMawid()
        // Do any additional setup after loading the view.
//        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addMawid))
    }
    

    
//
    func loadmawaid() {
        firestore.collection("Mawaid")
            .whereField("userid", isEqualTo: user)
            .getDocuments(
                completion: {
                    (qurySnapShot, error) in
                    if let error = error {
                        print(error.localizedDescription)
                    } else {
                        for document in qurySnapShot!.documents {
                            let data = document.data()
                            
                            self.mawaid.append(Mawid(clinicName: data["clinic Name"] as! String , patientName:  data["patient Name"] as! String , description:  data["description"] as! String , time:  data["time"] as! String , place:  data["place"] as! String ))
                            
                        }
                    }
                        self.mawaiydyTV.reloadData()
                }
            )
    }
//    @objc func addMawi() {
//        let vc = self.storyboard?.instantiateViewController(withIdentifier: "newMawid") as! NewMawidViewController
//        let nvc = UINavigationController(rootViewController: vc)
//        vc.modalPresentationStyle = .fullScreen
//        self.present(nvc, animated: true, completion: nil)
//    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
//    @IBAction func addMawid(_ sender: Any) {
//        let vc = self.storyboard?.instantiateViewController(withIdentifier: "newMawid") as! NewMawidViewController
////        let nvc = UINavigationController(rootViewController: vc)
//        vc.modalPresentationStyle = .fullScreen
//        self.present(vc, animated: true, completion: nil)
//    }
//
}

extension MawaiydyTV {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return mawaid.count
}

func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

    let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! MawaiydyTVCell
    cell.layer.cornerRadius = 10
    cell.clinicName.text = mawaid[indexPath.row].clinicName
    cell.time.text = mawaid[indexPath.row].time
    
    return cell
}
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selected = mawaid[indexPath.row]
        let vc = storyboard?.instantiateViewController(withIdentifier: "details") as! MawidDetails
        vc.mawaid = selected
        navigationController?.pushViewController(vc, animated: true)
    }
}
