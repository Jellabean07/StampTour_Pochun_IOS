//
//  GiftRequestViewController.swift
//  stamptour_pc
//
//  Created by kjw on 2016. 11. 10..
//  Copyright © 2016년 thatzit. All rights reserved.
//

import UIKit


class GiftRequestViewController: UIViewController,HttpResponse {
    
    let TAG : String = "GiftRequestViewController"
    var httpRequest : HttpRequestToServer?
    var Grade : String!
    override func viewDidLoad(){
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        self.httpRequest = HttpRequestToServer.init(TAG: TAG, delegate : self)
        NSLog(TAG, TAG)
        NSLog(self.Grade, "dd")
    }
    func HttpResult(_ reqPath : String, resCode: String, resMsg: String, resData: AnyObject) {
        //let data = resData["resultData"] as! String
       
    }

}
