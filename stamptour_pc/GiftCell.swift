//
//  GiftCell.swift
//  stamptour_pc
//
//  Created by kjw on 2016. 11. 4..
//  Copyright © 2016년 thatzit. All rights reserved.
//

import Foundation
import UIKit

class GiftCell: UITableViewCell {
    @IBOutlet var giftCount: UILabel!
    
    @IBOutlet var giftGrade: UILabel!
    
    @IBOutlet var giftSendBtn: UIButton!
    
    var buttonDelegate: GiftCellDelegate?
    @IBAction func buttonTap(_ sender: AnyObject) {
        if let delegate = buttonDelegate {
            delegate.cellTapped(cell: self)
        }
    }
}
