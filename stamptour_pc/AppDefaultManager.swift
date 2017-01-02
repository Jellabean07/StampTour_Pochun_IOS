//
//  AppDefaultManager.swift
//  stamptour_pc
//
//  Created by CSC-PC on 2016. 11. 2..
//  Copyright © 2016년 thatzit. All rights reserved.
//

import Foundation

class AppDefaultManager{
    
    init() {
        
    }
    
    func setGuideFirst(_ first : Bool){
        UserDefaults.standard.set(first, forKey: "guideFirst")
        UserDefaults.standard.synchronize()
    }

    func setUploadtime(_ uploadtime : String){
        UserDefaults.standard.set(uploadtime, forKey: "uploadtime")
        UserDefaults.standard.synchronize()
    }
    
    func setFirst(_ first : Bool){
        UserDefaults.standard.set(first, forKey: "first")
        UserDefaults.standard.synchronize()
    }
    
    func setVersion(_ version : Int){
        UserDefaults.standard.set(version, forKey: "version")
        UserDefaults.standard.synchronize()
    }
    
    func setSize(_ size : Int){
        UserDefaults.standard.set(size, forKey: "size")
        UserDefaults.standard.synchronize()
    }
    
    func getLastVersion() -> Bool {
        return UserDefaults.standard.bool(forKey: "first")
    }

    func getGuideFirst() -> Bool {
        if let first : Bool = UserDefaults.standard.bool(forKey: "guideFirst"){
            return first
        }else{
            return true
        }
    }

    
    func getVersion() -> Int {
        if let version : Int = UserDefaults.standard.integer(forKey: "version"){
            return version
        }else{
            return 0
        }
    }
    
   
    func getSize() -> Int {
        if let version : Int = UserDefaults.standard.integer(forKey: "size"){
            return version
        }else{
            return 0
        }
    }
    
    func getUploadtime() -> String {
        if let uploadtime : String  = UserDefaults.standard.string(forKey: "uploadtime"){
            return uploadtime
        }else{
            return ""
        }
    }
    
}
