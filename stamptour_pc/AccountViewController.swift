//
//  AccountViewController.swift
//  StampTour_GJ
//
//  Created by CSC-PC on 2016. 9. 9..
//  Copyright © 2016년 thatzit. All rights reserved.
//

import UIKit

class AcctManagerViewController : UIViewController , HttpResponse{
    
    let TAG : String = "AcctManagerViewController"
    var httpRequest : HttpRequestToServer?
    
    @IBOutlet var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        self.httpRequest = HttpRequestToServer.init(TAG: TAG, delegate : self)
        scrollView.contentSize.height = 667
    }
    
    
    func HttpResult(_ reqPath : String, resCode: String, resMsg: String, resData: AnyObject) {
        //let data = resData["resultData"] as! String
        
    }
}

class AcctIdentifyViewController : UIViewController , HttpResponse{
    
    let TAG : String = "AcctIdentifyViewController"
    var httpRequest : HttpRequestToServer?
    @IBOutlet var pass_txt: CustomTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        
        self.httpRequest = HttpRequestToServer.init(TAG: TAG, delegate : self)
    }
    
    @IBAction func pop(_ sender: AnyObject) {
        CommonFunction.dismiss(self)
    }
    
    @IBAction func submit(_ sender: AnyObject) {
        
    }
    func HttpResult(_ reqPath : String, resCode: String, resMsg: String, resData: AnyObject) {
        //let data = resData["resultData"] as! String
        
    }
}
