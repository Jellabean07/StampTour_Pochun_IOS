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
    let TAG = "FileBrowser"
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
    
    func currentFiles() {
        if let filePath = path?.appendingPathComponent("contents", isDirectory: true).appendingPathComponent("contents", isDirectory: true) {
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
        FileBrowser.init().fileExistCheck(fileName: "contents", defaultPath : false)
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
             let appDefualt = AppDefaultManager.init()
            appDefualt.setSize(0)
            appDefualt.setVersion(0)
            appDefualt.setUploadtime("")
            
        }
    }
  
    func readFromDocumentsFile(fileName:String) -> String {
        let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0].appending("/contents").appending("/contents") as NSString
        let path = documentsPath.appendingPathComponent(fileName)
    
        print(path)
        var readText : String = ""
        
        do {
            try readText = NSString(contentsOfFile: path, encoding: String.Encoding.utf8.rawValue) as String
        }
        catch let error as NSError {
            print("ERROR : reading from file \(fileName) : \(error.localizedDescription)")
        }
        return readText
    }
    
    func fileExistCheck(fileName : String, defaultPath : Bool){
        var path : String?
        if defaultPath{
            path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        }else{
            path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0].appending("/contents") as String
        }
        
        print("\(TAG) : fileExistCheck : \(path!)")
        let url = NSURL(fileURLWithPath: path!)
        let filePath = url.appendingPathComponent(fileName)?.path
        let fileManager = FileManager.default
        if fileManager.fileExists(atPath: filePath!) {
             print("FILE AVAILABLE")
            do {
                try fileManager.removeItem(atPath:  filePath!)
                print("\(TAG) : Success remove item")
            }
            catch let error as NSError {
                print("\(TAG) : Something went wrong: \(error)")
            }
        } else {
            print("FILE NOT AVAILABLE")
        }
    }
    
    func getDefaultDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0].appendingPathComponent("contents", isDirectory: true).appendingPathComponent("contents", isDirectory: true)
        return documentsDirectory
    }
    
    func isExsitString(fileName : String) -> Bool{
        var path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0].appending("/contents").appending("/contents") as String
        
        print("\(TAG) : fileExistCheck : \(path)")
        let url = NSURL(fileURLWithPath: path)
        let filePath = url.appendingPathComponent(fileName)?.path
        let fileManager = FileManager.default
        if fileManager.fileExists(atPath: filePath!) {
            return true
        } else {
            return false
        }
    }
    
    func getImage(named : String) -> UIImage{
        var path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0].appending("/contents").appending("/contents") as String
        
        // print("\(TAG) : getImage : \(path)")
        let url = NSURL(fileURLWithPath: path)
        let imagePAth = url.appendingPathComponent(named)?.path
        
        let fileManager = FileManager.default
        if fileManager.fileExists(atPath: imagePAth!){
            print("load Image : \(named)")
            return UIImage(contentsOfFile: imagePAth!)!
        }else{
            print("No Image : \(named)")
            return UIImage(named : "img_no_img")!
        }
    }
    
    func getTownImgString(townNo : String) -> [String]{
        let no : Int = Int(townNo)!
        var townImg : [String] = [String]()
        
        for index in 1...5 {
            let imgStr = "town\(no)_\(index).png"
            print("\(TAG) : imgStr : \(imgStr)")
            if isExsitString(fileName: imgStr) {
                townImg.append(imgStr)
                print("\(TAG) : imgStr append")
            }else{
                print("\(TAG) : imgStr not append")
                
            }
        }
        return townImg
    }
    
    func fileLocalizationReadJson() -> String{
        let langStr = LocalizationManager.shared.getLanguageCode()
        print("\(TAG) : language code : \(langStr) ")
        
        let langCode = LocalizationManager.shared.getConvertContentsLanguageCode(code: langStr )
        return readFromDocumentsFile(fileName: "\(langCode).json")
    }
    
    func convertJsonArray(text : String){
        var townList = [ContentsVO]()
        if let data = text.data(using: String.Encoding.utf8) {
            do {
                let apiDictionary = try JSONSerialization.jsonObject(with: data, options: [])
                if let apiDictionary = apiDictionary as? NSArray {
                    for row in apiDictionary{
                        let obj = row as! NSDictionary
                        let no = obj["번호"] as! String
                        let title = obj["명소명"] as! String
                        let region = obj["권역명"] as! String
                        let latitude = obj["위도"] as! String
                        let longitude = obj["경도"] as! String
                        let range = obj["반경"] as! String
                        let subtitle = obj["서브타이틀"] as! String
                        let intro = obj["소개내용"] as! String
                        let imgStr = getTownImgString(townNo: no)
                        
                        
                        let mvo = ContentsVO(no: no, title: title, subtitle: subtitle, region: region, latitude: latitude, longitude: longitude, range: range, intro: intro, imgStr : imgStr)
                        townList.append(mvo)
                    }
                  
                }

            } catch {
                print("\(TAG) : Something went wrong")
            }
           StampDefaultManager.init().setTownList(townList : townList)
        }
    }
}
