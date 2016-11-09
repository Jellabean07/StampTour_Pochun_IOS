//
//  InsertDummy.swift
//  stamptour_pc
//
//  Created by CSC-PC on 2016. 11. 8..
//  Copyright © 2016년 thatzit. All rights reserved.
//

import Foundation


class InsertDummy {
    
    init() {
        
    }
    
    func setDummy(){
        if UserDefaults.standard.bool(forKey: "first") == false {
            UserDefaults.standard.set(true, forKey: "first")
            UserDefaults.standard.synchronize()
            let fileManager = FileManager.default
            let fileName = "contents.zip"
            let documentsUrl = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0] as URL
            let bundleUrl = Bundle.main.resourceURL
            if let srcPath = bundleUrl?.appendingPathComponent(fileName).path{
                let toPath = documentsUrl.appendingPathComponent(fileName).path
                do {
                    try fileManager.copyItem(atPath: srcPath, toPath: toPath)
                } catch {}
            }
        }
        
        unZipDummy()
    }
    
    func unZipDummy(){
        let fileBrowser = FileBrowser.init()
        fileBrowser.setUnZip(file: "contents.zip")
        fileBrowser.updateFiles()
    }
}
