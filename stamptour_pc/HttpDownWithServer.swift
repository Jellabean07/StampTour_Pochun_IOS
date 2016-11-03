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
    
    //작업중
//    func download(_ reqPath : String, reqParameter : Parameters){
//        print("\(self.TAG!) : reqURL : \(HttpReqPath.HttpHost+reqPath)")
//        print("\(self.TAG!) : reqParameter : \(reqParameter)")
//        
//       
//        let fileURL: URL
//        let destination: DownloadRequest.DownloadFileDestination = { _, _ in
//            return (fileURL, [.createIntermediateDirectories, .removePreviousFile])
//        }
//        let parameters: Parameters = ["foo": "bar"]
//        
//        Alamofire.download(HttpReqPath.HttpHost+reqPath, method: .get, parameters: parameters, encoding: JSONEncoding.default, to: destination)
//            .downloadProgress(queue: DispatchQueue.global(qos: .utility)) { progress in
//                print("Progress: \(progress.fractionCompleted)")
//            }
//            .validate { request, response, temporaryURL, destinationURL in
//                // Custom evaluation closure now includes file URLs (allows you to parse out error messages if necessary)
//                return .success
//            }
//            .responseJSON { response in
//                debugPrint(response)
//                print(response.temporaryURL)
//                print(response.destinationURL)
//        }
//    
//    }
    
}
