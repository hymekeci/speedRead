//
//  contentCell.swift
//  ReadSpeed
//
//  Created by MA on 2020/1/15.
//  Copyright © 2020 mfk. All rights reserved.
//

import UIKit

class contentCell: UITableViewCell {

    
    @IBOutlet weak var levelMarkImg: UIImageView!
    @IBOutlet weak var exerciseTitleLbl: UILabel!
    @IBOutlet weak var exerciseContentLbl: UILabel!
    @IBOutlet weak var levelLbl: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
