//
//  TextValidation.swift
//  StampTour_GJ
//
//  Created by CSC-PC on 2016. 9. 5..
//  Copyright © 2016년 thatzit. All rights reserved.
//

import Foundation
class TextValidation {
    
    let pass_patten = "^(?=.*[a-z]+)(?=.*[0-9]+).{6,16}$"
    let email_patten = "[\\w\\~\\-\\.]+@[\\w\\~\\-]+(\\.[\\w\\~\\-]+)+"
    let name_patten = "^[a-zA-Z0-9가-힣\\u318D\\u119E\\u11A2\\u2022\\u2025a\\u00B7\\uFE55]{2,7}+$"
    
    init(){
        
    }
    
    func isValidPassword(_ testStr:String!) -> Bool {
        let passRegEx = self.pass_patten
        let passTest = NSPredicate(format:"SELF MATCHES %@", passRegEx)
        let result = passTest.evaluate(with: testStr)
        return result
    }
    
    func isValidEmail(_ testStr:String!) -> Bool {
        let emailRegEx = self.email_patten
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let result = emailTest.evaluate(with: testStr)
        return result
    }
    
    func isValidName(_ testStr:String!) -> Bool {
        let nameRegEx = self.name_patten
        let nameTest = NSPredicate(format:"SELF MATCHES %@", nameRegEx)
        let result = nameTest.evaluate(with: testStr)
        return result
    }
}
