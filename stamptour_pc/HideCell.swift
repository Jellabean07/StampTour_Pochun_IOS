//
//  HideCell.swift
//  stamptour_pc
//
//  Created by CSC-PC on 2016. 11. 22..
//  Copyright © 2016년 thatzit. All rights reserved.
//

import Foundation
import UIKit

class HideCell : UITableViewCell {
    
    @IBOutlet var thumbnail: UIImageView!
    @IBOutlet var name: UILabel!
    @IBOutlet var region: UILabel!
    @IBOutlet var hideClear: OverlapButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
