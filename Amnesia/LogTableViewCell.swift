//
//  LogTableViewCell.swift
//  Amnesia
//
//  Created by Mike Keegan on 10/8/16.
//  Copyright © 2016 mikekeegan. All rights reserved.
//

import UIKit

class LogTableViewCell: UITableViewCell {
    
    @IBOutlet weak var testLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func changeLabelText(newText: String){
        testLabel.text = newText
    }
    
    func changeTimeText(newText: String){
        timeLabel.text = newText
    }

}
