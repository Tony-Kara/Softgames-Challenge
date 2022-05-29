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
