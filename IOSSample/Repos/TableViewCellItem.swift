//
//  TableViewCellItem.swift
//  IOSSample
//
//  Created by Ankit Kumar on 26/01/2018.
//  Copyright © 2018 Ankit Kumar. All rights reserved.
//

import UIKit

class TableViewCellItem: UITableViewCell {

   // @IBOutlet weak var lbl2: UILabel!
    @IBOutlet weak var lbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
