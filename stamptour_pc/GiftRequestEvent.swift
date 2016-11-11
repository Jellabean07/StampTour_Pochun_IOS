//
//  GiftRequestEvent.swift
//  stamptour_pc
//
//  Created by kjw on 2016. 11. 11..
//  Copyright © 2016년 thatzit. All rights reserved.
//

import Foundation

class GiftRequestEvent {
    var status:Bool
    var giftSendDelegate: GiftSendDelegate?
    init(status:Bool,giftSendDelegate:GiftSendDelegate) {
        self.status = status
        self.giftSendDelegate = giftSendDelegate
    }
    func refresh(){
        if let delegate = giftSendDelegate {
            delegate.Tapped(event: self)
        }
    }
}
