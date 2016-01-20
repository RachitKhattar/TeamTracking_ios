//
//  AppContext.swift
//  TeamTracking
//
//  Created by Rachit on 20/01/16.
//
//

import UIKit

class AppContext: NSObject {

    static let sharedInstance = AppContext()
    
    var users = [String: User]()
    /*
    To add ["key": UserObject] to users-
    users["key"] = UserObject
    
    To access UserObject corresponding to key-
    users["key"]
    */
    
    
    var roomNumber: Int!
    var long: Double!
    var lat: Double!
    
}
