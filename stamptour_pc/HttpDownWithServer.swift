//
//  HttpDownloadWithServer.swift
//  stamptour_pc
//
//  Created by CSC-PC on 2016. 11. 2..
//  Copyright © 2016년 thatzit. All rights reserved.
//

import Foundation
import Alamofire


class HttpDownWithServer {
    
    var TAG : String?
    var delegate : HttpResponse?
    
    init(TAG : String, delegate : HttpResponse){
        self.TAG = TAG
        self.delegate = delegate
        
        
    }
    
    func setDestination(){
        let fileManager = FileManager.default
        let fileName = "Images.zip"
        let documentsUrl = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0] as URL
        let bundleUrl = Bundle.main.resourceURL
        if let srcPath = bundleUrl?.appendingPathComponent(fileName).path{
            let toPath = documentsUrl.appendingPathComponent(fileName).path
            do {
                try fileManager.copyItem(atPath: srcPath, toPath: toPath)
            } catch {}
        }
    }

    func download(_ reqPath : String, reqParameter : Parameters){
        print("\(self.TAG!) : reqURL : \(HttpReqPath.HttpHost+reqPath)")
        print("\(self.TAG!) : reqParameter : \(reqParameter)")
        
        //let destination = DownloadRequest.suggestedDownloadDestination(for: .documentDirectory)
        
       let destination = DownloadRequest.suggestedDownloadDestination(for: .documentDirectory, in: .userDomainMask)
        
        let nick = "?nick=\(String(describing: reqParameter["nick"]!))&"
        let token = "accesstoken=\(String(describing: reqParameter["accesstoken"]!))"
        let pathURL = HttpReqPath.HttpHost+reqPath+nick+token
        print(pathURL)
        
       // Alamofire.request(HttpReqPath.HttpHost+reqPath, method:.get)
        Alamofire.download(HttpReqPath.HttpHost+reqPath, method:.get, parameters: reqParameter, to : destination)
       // Alamofire.download(HttpReqPath.HttpHost+reqPath, method: .get, parameters: reqParameter, encoding: JSONEncoding.default, to: destination)
            .downloadProgress(queue: DispatchQueue.global(qos: .utility)) { progress in
                print("Progress: \(progress.fractionCompleted)")
            }
            .validate { request, response, temporaryURL, destinationURL in
                // Custom evaluation closure now includes file URLs (allows you to parse out error messages if necessary)
                return .success
            }
            .responseJSON { response in
                

                debugPrint(response)
                print("temporaryURL : \(response.temporaryURL!)")
                print("destinationURL : \(response.destinationURL!)")
                
                let fileBrowser = FileBrowser.init()
                fileBrowser.updateFiles()
                //fileBrowser.fileUnZip(pathURL: response.destinationURL!)
        }
    
    }
    
}
