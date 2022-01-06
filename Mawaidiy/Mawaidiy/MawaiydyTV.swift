//
//  MawaiydyTV.swift
//  Mawaidiy
//
//  Created by Sahab Alharbi on 29/05/1443 AH.
//

import UIKit

class MawaiydyTV: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var mawaiydyTV: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        mawaiydyTV.delegate = self
        mawaiydyTV.dataSource = self
        // Do any additional setup after loading the view.
//        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addMawid))
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
    @IBAction func addMawid(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "newMawid") as! NewMawidViewController
//        let nvc = UINavigationController(rootViewController: vc)
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
}

extension MawaiydyTV {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return 10
}

func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

    let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! MawaiydyTVCell
    
    return cell
}
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        <#code#>
    }
}
