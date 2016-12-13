//
//  TermsViewController.swift
//  stamptour_pc
//
//  Created by CSC-PC on 2016. 12. 12..
//  Copyright © 2016년 thatzit. All rights reserved.
//

import UIKit

class TermsViewController : UIViewController{
    var terms_msg1 = NSLocalizedString("terms_msg1", comment: "약관")
    var terms_msg2 = NSLocalizedString("terms_msg2", comment: "약관")
    var terms_msg3 = NSLocalizedString("terms_msg3", comment: "약관")
    var terms_msg4 = NSLocalizedString("terms_msg4", comment: "약관")
    var terms_msg5 = NSLocalizedString("terms_msg5", comment: "약관")
    var terms_msg6 = NSLocalizedString("terms_msg6", comment: "약관")
    var terms_msg7 = NSLocalizedString("terms_msg7", comment: "약관")
    var terms_msg10 = NSLocalizedString("terms_msg8", comment: "약관")
    var terms_msg12 = NSLocalizedString("terms_msg9", comment: "약관")
    
    @IBOutlet var terms_msg: UITextView!
    override func viewDidLoad() {
        self.terms_msg.text = terms_msg1+terms_msg2+terms_msg3+terms_msg4+terms_msg5+terms_msg6+terms_msg10+terms_msg12
    }
}
