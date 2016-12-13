//
//  CommonFunction.swift
//  StampTour_GJ
//
//  Created by CSC-PC on 2016. 9. 5..
//  Copyright © 2016년 thatzit. All rights reserved.
//

import Foundation
import UIKit


class CommonFunction {
    
    
    static func dismiss(_ selfView : UIViewController){
        if(selfView == selfView.navigationController?.viewControllers[0]){
            selfView.dismiss(animated: true, completion: nil)
        }else{
            selfView.navigationController?.popViewController(animated: true)
        }
    }
    
    static func moveToController(uvc : UIViewController){
        typealias viewControllerType = MainViewController
        let viewController = uvc.storyboard?.instantiateViewController(withIdentifier: "MainViewController") as! viewControllerType
        
        uvc.present(viewController, animated:true, completion: nil)
        
//        let navController = UINavigationController(rootViewController: viewController)
//        uvc.present(navController, animated:true, completion: nil)
    }
    
    //html 태그 사용하는 문자열로 바꿔줌
    static func htmlToText(encodedString:String) -> String?
    {
        let encodedData = encodedString.data(using: String.Encoding.utf8)!
        do
        {
            return try NSAttributedString(data: encodedData, options: [NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType,NSCharacterEncodingDocumentAttribute:String.Encoding.utf8], documentAttributes: nil).string
        } catch let error as NSError {
            print(error.localizedDescription)
            return nil
        }
    }
}

extension String {
    var html2AttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return nil }
        do {
            return try NSAttributedString(data: data, options: [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType, NSCharacterEncodingDocumentAttribute: String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch let error as NSError {
            print(error.localizedDescription)
            return  nil
        }
    }
    var html2String: String {
        return html2AttributedString?.string ?? ""
    }
}
