//
//  personCell.swift
//  CoreDataProject
//
//  Created by Durvesh Manjhi on 15/07/25.
//

import UIKit

class personCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var ageText: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
