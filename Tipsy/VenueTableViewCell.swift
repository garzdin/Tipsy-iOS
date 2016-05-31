//
//  VenueTableViewCell.swift
//  Tipsy
//
//  Created by Teodor on 31/05/16.
//  Copyright © 2016 TeodorGarzdin. All rights reserved.
//

import UIKit

class VenueTableViewCell: UITableViewCell {
    
    var favorited: Bool = false
    @IBOutlet var venueNameLabel: UILabel!
    @IBOutlet var venueLabelMessage: UILabel!
    @IBOutlet var venueLabelAddress: UILabel!
    @IBOutlet var venueLabelTimes: UILabel!
    @IBOutlet var venueLabelMusic: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func getDrinkAction(sender: UIButton) {
        print("Got drink")
    }
    
    @IBAction func shareAction(sender: UIButton) {
        print("Shared")
    }
    
    @IBAction func favoriteAction(sender: UIButton) {
        if(favorited) {
            favorited = false
            sender.setImage(UIImage(named: "NotFavorited"), forState: .Normal)
        } else {
            favorited = true
            sender.setImage(UIImage(named: "Favorited"), forState: .Normal)
        }
    }
}
