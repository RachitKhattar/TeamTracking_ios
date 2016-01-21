//
//  AppSettings.swift
//  TeamTracking
//
//  Created by Rachit on 20/01/16.
//
//

import UIKit

class AppSettings: NSObject {
    
    static let sharedInstance = AppSettings()
    
    override init() {
        super.init()
        NSUserDefaults.standardUserDefaults().registerDefaults([
            "userName": "rachit"
            ])
    }
    
    var userName: String {
        get{
            let key = self.userDefaultForKey("userName")
            return key as! String
        }
        set(value) {
            self.setUserDefaultValueForKey(value, key: "userName")
        }
    }
    
    // MARK: Private methods
    func userDefaultForKey(key: String) -> AnyObject? {
        let defaults = NSUserDefaults.standardUserDefaults()
        return defaults.objectForKey(key)
    }
    
    func setUserDefaultValueForKey(value: AnyObject, key: String) {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setValue(value, forKey: key)
        defaults.synchronize()
    }
    
}
