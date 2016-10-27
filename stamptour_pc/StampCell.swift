//
//  StampCell.swift
//  stamptour_pc
//
//  Created by CSC-PC on 2016. 9. 30..
//  Copyright © 2016년 thatzit. All rights reserved.
//

import UIKit
import Foundation

class NormalCell : UITableViewCell{
    
    @IBOutlet var vil_thumbnail: UIImageView!
    @IBOutlet var vil_name: UILabel!
    @IBOutlet var vil_region: UILabel!
    @IBOutlet var vil_distance: UILabel!
    
}


class ActiveCell : UITableViewCell{
    
    @IBOutlet var vil_thumbnail: UIImageView!
    @IBOutlet var vil_name: UILabel!
    @IBOutlet var vil_region: UILabel!
    
}


class CompleteCell : UITableViewCell{
    
    @IBOutlet var vil_thumbnail: UIImageView!
    @IBOutlet var vil_name: UILabel!
    @IBOutlet var vil_region: UILabel!
    @IBOutlet var vil_distance: UILabel!
    @IBOutlet var vil_date: UILabel!
    @IBOutlet var vil_count: UILabel!
    
}

