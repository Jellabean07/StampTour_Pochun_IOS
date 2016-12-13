//
//  ActionDisplay.swift
//  StampTour_GJ
//
//  Created by CSC-PC on 2016. 8. 25..
//  Copyright © 2016년 thatzit. All rights reserved.
//

import Foundation
import UIKit


class ActionDisplay{
    
    var uvc : UIViewController?
    let cancel_txt = NSLocalizedString("comm_cancel", comment: "취소")
    let ok_txt = NSLocalizedString("comm_ok", comment: "OK")
    let no_txt = NSLocalizedString("comm_no", comment: "NO")
    
    init(uvc : UIViewController){
        self.uvc = uvc
    }
    
    func displayMyAlertMessage(_ userMessage:String)
    {
        let myAlert=UIAlertController(title:"",message: userMessage,preferredStyle: UIAlertControllerStyle.alert);
        let okAction=UIAlertAction(title:ok_txt,style: UIAlertActionStyle.default,handler: nil);
        
        myAlert.addAction(okAction);
        self.uvc!.present(myAlert, animated: true, completion: nil);
    }
    func displayMyAlertMessageDismissView(_ userMessage:String)
    {
        let myAlert=UIAlertController(title:"",message: userMessage,preferredStyle: UIAlertControllerStyle.alert);
        let okAction=UIAlertAction(title:ok_txt,style: UIAlertActionStyle.default,handler: {
            (_)in
            CommonFunction.dismiss(self.uvc!)
        });
        
        myAlert.addAction(okAction);
        self.uvc!.present(myAlert, animated: true, completion: nil);
    }
    func displayMyAlertMessageAction(_ userMessage:String, action: @escaping (Void)->Void)
    {
        let myAlert=UIAlertController(title:"",message: userMessage,preferredStyle: UIAlertControllerStyle.alert);
        let okAction=UIAlertAction(title:ok_txt,style: UIAlertActionStyle.default,handler: {
            (_)in
            action()
        });
        
        myAlert.addAction(okAction);
        self.uvc!.present(myAlert, animated: true, completion: nil);
    }
    
    func displayMyAlertMessageActionYN(_ userMessage:String, action : @escaping (Void) -> Void)
    {
        let myAlert=UIAlertController(title:"",message: userMessage,preferredStyle: UIAlertControllerStyle.alert);
        let yAction=UIAlertAction(title:ok_txt,style: UIAlertActionStyle.default,handler: {
            (_) in
            action()
        });
        let nAction=UIAlertAction(title:no_txt,style: .cancel,handler: nil);
        myAlert.addAction(yAction);
        myAlert.addAction(nAction)
        self.uvc!.present(myAlert, animated: true, completion: nil);
    }
    
    func displayMyAlertMessageActionFromUvc(_ userMessage:String, action : @escaping (UIViewController) -> Void)
    {
        let myAlert=UIAlertController(title:"",message: userMessage,preferredStyle: UIAlertControllerStyle.alert);
        let okAction=UIAlertAction(title:ok_txt,style: UIAlertActionStyle.default,handler: {
            (_)in
            action(self.uvc!)
        });
        
        myAlert.addAction(okAction);
        self.uvc!.present(myAlert, animated: true, completion: nil);
    }
    
    
    func displayMyAlertMessesgeList(_ title : String, userMessege:String, actionList:Array<ActionVO>){
        let mAlert = UIAlertController(title: title,message: userMessege,preferredStyle: UIAlertControllerStyle.alert);
        let cancelAction = UIAlertAction(title: cancel_txt, style: .cancel, handler: nil)
        
        mAlert.addAction(cancelAction)
        
        for row in actionList{
            let action = UIAlertAction(title: row.title, style: .default, handler: {
                (_) in
                row.action()
            })
            mAlert.addAction(action)
        }
        
        self.uvc!.present(mAlert, animated: true, completion: nil);
    }
    
    func displayCameraMessesgeList(_ userMessege:String, actionList:Array<ActionVO>){
        let mAlert = UIAlertController(title:"이미지 업로드",message: userMessege,preferredStyle: UIAlertControllerStyle.alert);
        let cancelAction = UIAlertAction(title: cancel_txt, style: .cancel, handler: nil)
        
        mAlert.addAction(cancelAction)
        
        for row in actionList{
            let action = UIAlertAction(title: row.title, style: .default, handler: {
                (_) in
                row.action()
            })
            mAlert.addAction(action)
        }
        
        self.uvc!.present(mAlert, animated: true, completion: nil);
    }
    // Mark - ActionSheet
    
    func showActionSheet(_ userTitle:String,userMessege:String,actionList:Array<ActionVO>){
        // create controller with style as ActionSheet
        let alertCtrl = UIAlertController(title: userTitle, message: userMessege, preferredStyle: UIAlertControllerStyle.actionSheet)
        let cancelAction = UIAlertAction(title: cancel_txt, style: UIAlertActionStyle.cancel, handler: nil)
        
        for row in actionList{
            let action = UIAlertAction(title: row.title, style: .default, handler: {
                (_) in
                row.action()
            })
            alertCtrl.addAction(action)
        }
        
        alertCtrl.addAction(cancelAction)
        
        // show action sheet
        self.uvc!.present(alertCtrl, animated: true, completion: nil)
        
    }
    
    func showActionSheetParaAction(_ userTitle:String,userMessege:String,actionList:Array<ActionParaVO>){
        // create controller with style as ActionSheet
        let alertCtrl = UIAlertController(title: userTitle, message: userMessege, preferredStyle: UIAlertControllerStyle.actionSheet)
        let cancelAction = UIAlertAction(title: cancel_txt, style: UIAlertActionStyle.cancel, handler: nil)
        
        for row in actionList{
            let action = UIAlertAction(title: row.title, style: .default, handler: {
                (_) in
                row.play()
            })
            alertCtrl.addAction(action)
        }
        
        alertCtrl.addAction(cancelAction)
        
        // show action sheet
        self.uvc!.present(alertCtrl, animated: true, completion: nil)
        
    }
    
    func showActionSheetCodeAction(_ userTitle:String,userMessege:String,actionList: [ActionCodeVO]){
        // create controller with style as ActionSheet
        let alertCtrl = UIAlertController(title: userTitle, message: userMessege, preferredStyle: UIAlertControllerStyle.actionSheet)
        let cancelAction = UIAlertAction(title: cancel_txt, style: UIAlertActionStyle.cancel, handler: nil)
        
        for row in actionList{
            let action = UIAlertAction(title: row.title, style: .default, handler: {
                (_) in
                row.play()
            })
            alertCtrl.addAction(action)
        }
        
        alertCtrl.addAction(cancelAction)
        
        // show action sheet
        self.uvc!.present(alertCtrl, animated: true, completion: nil)
        
    }
    
}
