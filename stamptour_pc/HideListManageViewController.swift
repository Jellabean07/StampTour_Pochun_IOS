//
//  HideListManageViewController.swift
//  stamptour_pc
//
//  Created by kjw on 2016. 11. 3..
//  Copyright © 2016년 thatzit. All rights reserved.
//

import UIKit


class HideListManageViewController : UIViewController , HttpResponse{
    
    let TAG : String = "HideListManageViewController"
    var httpRequest : HttpRequestToServer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        self.httpRequest = HttpRequestToServer.init(TAG: TAG, delegate : self)
    }
    
    
    func HttpResult(_ reqPath : String, resCode: String, resMsg: String, resData: AnyObject) {
        //let data = resData["resultData"] as! String
        
    }
    @IBAction func pop(_ sender: AnyObject) {
        CommonFunction.dismiss(self)
    }
}
