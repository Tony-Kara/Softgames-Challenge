//
//  UserData.swift
//  WebKitDemo
//
//  Created by Mushtaque Ahmed on 10/15/19.
//  Copyright © 2019 Mushtaque Ahmed. All rights reserved.
//

import Foundation


class UserData {
    var firstName : String = ""
    var lastname : String = ""
    var dob : String = ""
    
    
    init(_ firstName:String , _ lastname:String , _ dob : String) {
        self.firstName = firstName
        self.lastname = lastname
        self.dob = dob
    }
}
