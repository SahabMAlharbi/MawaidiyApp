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

extension MawaiydyTV {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return 10
}

func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

    let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! MawaiydyTVCell
    
    return cell
}
}
