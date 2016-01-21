//
//  LocationTableViewCell.swift
//  TeamTracking
//
//  Created by Diwakar Kamboj on 20/01/16.
//
//

import UIKit

class LocationTableViewCell: UITableViewCell {
    
    @IBOutlet weak var userDistanceLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userColorView: UIView!
    var user : User! {
        didSet {
            userDistanceLabel.text = self.user.available ? String(format: "%.2f m  ", self.user.distance) : "?  "
            userNameLabel.text = self.user.name
            userColorView.backgroundColor = self.user.color
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
