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

    func download(_ reqPath : String, reqParameter : Parameters){
        print("\(self.TAG!) : reqURL : \(HttpReqPath.HttpHost+reqPath)")
        print("\(self.TAG!) : reqParameter : \(reqParameter)")
        
        //let destination = DownloadRequest.suggestedDownloadDestination(for: .documentDirectory)
        let destination = DownloadRequest.suggestedDownloadDestination(
            for: .cachesDirectory,
            in: .userDomainMask
        )
        Alamofire.download(HttpReqPath.HttpHost+reqPath, method: .get, parameters: reqParameter, encoding: JSONEncoding.default, to: destination)
            .downloadProgress(queue: DispatchQueue.global(qos: .utility)) { progress in
                print("Progress: \(progress.fractionCompleted)")
            }
            .validate { request, response, temporaryURL, destinationURL in
                // Custom evaluation closure now includes file URLs (allows you to parse out error messages if necessary)
                return .success
            }
            .responseJSON { response in
                switch response.result {
                case .success:
                    print("\(self.TAG!) : Validation Successful")
                    //print("Validation Successful")
                    //print(response.request)  // original URL request
                    //print(response.response) // URL response
                    //print(response.data)     // server data
                    //print(response.result)   // result of response serialization
                    
                    if let JSON = response.result.value {
                        print("\(self.TAG!) : JSON : succ")
                        //print("\(self.TAG!) : JSON : \(JSON)")
                    }
                    
                    var Response: Data;
                    do {
                        Response = try JSONSerialization.data(withJSONObject: response.result.value!, options: JSONSerialization.WritingOptions.prettyPrinted)
                        let apiDictionary = try JSONSerialization.jsonObject(with: Response, options: [])
                        
                        
                        if let apiDictionary = apiDictionary as? [String: Any] {
                            let resCode = apiDictionary["code"] as! String
                            let resMsg = apiDictionary["message"] as! String
                            let resData = apiDictionary
                            
                            print("\(self.TAG!) : reqPath = \(reqPath)")
                            print("\(self.TAG!) : resCode = \(resCode)")
                            print("\(self.TAG!) : resMsg = \(resMsg)")
                            print("\(self.TAG!) : resData = \(resData)")
                            
                            //00 : 정상
                            //01  : 데이터 불충분 혹은 유효하지 않은 입력
                            //02 : DB쿼리는 정상처리 되었으나 결과가 없는 경우
                            //03 : DB에러
                            
                            //응답 메시지 message의 값
                            //SUCCESS : 성공
                            //FAIL : 실패
                            //invalid Input : xxxx  파라미터값이 xxxx에들어감
                            
                            if(resCode == "00"){
                                self.delegate?.HttpResult(reqPath,resCode : resCode, resMsg: resMsg, resData: resData as AnyObject)
                            }else if(resCode == "01"){
                                
                            }else if(resCode == "02"){
                                
                            }else if(resCode == "03"){
                                
                            }else{
                                
                                
                            }
                        }
                        
                    }catch let myJSONError {
                        print("\(self.TAG!) : \(myJSONError)")
                        
                    }
                    
                case .failure(let error):
                    print("\(self.TAG!) : \(error)")
                }

                debugPrint(response)
                print(response.temporaryURL)
                print(response.destinationURL)
        }
    
    }
    
}
