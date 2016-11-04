//
//  HttpRequestPath.swift
//  StampTour_GJ
//
//  Created by CSC-PC on 2016. 9. 5..
//  Copyright © 2016년 thatzit. All rights reserved.
//

import Foundation

class HttpReqPath {
    
    static let HttpHost = "http://stamptourshinan.mybluemix.net"
//    static let HttpHost = "http://stamptourpochon.mybluemix.net"
    static let VersionCheck = "/user/check/version"
    static let ContentsReq = "/town/contents/contents.zip"
    static let LoginReq = "/user/login"
    static let LogoutReq = "/user/logout"
    static let JoinReq = "/user/join"
    static let JoinIdOverlap = "/user/id/check"
    static let JoinNickOverlap = "/user/nick/check"
    static let ForgetPass = "/user/find/password"
    static let ForgetId = "/user/find/id"
    static let StampListReq = "/town/list"
    static let StampSealReq = "/stamp/check"
    static let UserInfoReq = "/user/info"
    static let PasswordChangeReq = "/user/change/password"
    static let UserRemoveReq = "/user/remove"
    
}
