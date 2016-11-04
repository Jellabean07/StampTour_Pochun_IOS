//
//  FileBrowser.swift
//  stamptour_pc
//
//  Created by CSC-PC on 2016. 11. 3..
//  Copyright © 2016년 thatzit. All rights reserved.
//

import Foundation
import UIKit
import Zip

class FileBrowser {
    let fileManager = FileManager.default
    
    var path: URL? {
        didSet {
            updateFiles()
        }
    }
    
    
    var files = [String]()
    
    var selectedFiles = [String]()
    
    //MARK: Lifecycle
    
    init() {
        if self.path == nil {
            let documentsUrl = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0] as URL
            self.path = documentsUrl
        }
    }
    
    
    //MARK: File manager
    
    func updateFiles() {
        if let filePath = path {
            var tempFiles = [String]()
            do  {
                //self.title = filePath.lastPathComponent
                tempFiles = try self.fileManager.contentsOfDirectory(atPath: filePath.path)
            } catch {
                if filePath.path == "/System" {
                    tempFiles = ["Library"]
                }
                if filePath.path == "/Library" {
                    tempFiles = ["Preferences"]
                }
                if filePath.path == "/var" {
                    tempFiles = ["mobile"]
                }
                if filePath.path == "/usr" {
                    tempFiles = ["lib", "libexec", "bin"]
                }
            }
            self.files = tempFiles.sorted(){$0 < $1}
          //  tableView.reloadData()
            
            print(self.files)
        
        }
    }
    
    func setUnZip(file : String){
        let filePath = file
        let pathURL = path!.appendingPathComponent(filePath)
        print("pathURL : \(pathURL)")
        do {
            let _ = try Zip.quickUnzipFile(pathURL)
            updateFiles()
        } catch {
            print("ERROR")
        }
    }
    
    func fileUnZip(pathURL : URL){
        print("pathURL : \(pathURL)")
        do {
            let _ = try Zip.quickUnzipFile(pathURL)
            updateFiles()
        } catch {
            print("ERROR")
        }
    }
    
    func setZip(){
        var urlPaths = [URL]()
        for filePath in selectedFiles {
            urlPaths.append(path!.appendingPathComponent(filePath))
        }
        do {
            let _ = try Zip.quickZipFiles(urlPaths, fileName: "Archive")
            self.selectedFiles.removeAll()
           // updateSelection()
            updateFiles()
        } catch {
            print("ERROR")
        }
    }

}
