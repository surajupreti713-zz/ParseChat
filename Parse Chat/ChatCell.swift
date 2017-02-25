//
//  ChatCell.swift
//  Parse Chat
//
//  Created by Suraj Upreti on 2/24/17.
//  Copyright © 2017 Suraj Upreti. All rights reserved.
//

import UIKit

class ChatCell: UITableViewCell {

    @IBOutlet weak var messageTextLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        messageTextLabel.layer.cornerRadius = 3
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }


}
