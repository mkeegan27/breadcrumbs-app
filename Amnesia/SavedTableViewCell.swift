//
//  SavedTableViewCell.swift
//  Amnesia
//
//  Created by Mike Keegan on 10/9/16.
//  Copyright © 2016 mikekeegan. All rights reserved.
//

import UIKit

class SavedTableViewCell: UITableViewCell {
    @IBOutlet weak var saveNameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        saveNameLabel.adjustsFontSizeToFitWidth = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    

    func changeSaveLabel(newText: String){
        saveNameLabel.text = newText
    }

}
