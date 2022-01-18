//
//  MawaiydyTVCell.swift
//  Mawaidiy
//
//  Created by Sahab Alharbi on 29/05/1443 AH.
//

import UIKit

class MawaiydyTVCell: UITableViewCell {
    @IBOutlet weak var clinicName: UILabel!
    @IBOutlet weak var time: UILabel!
   
    
  
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
