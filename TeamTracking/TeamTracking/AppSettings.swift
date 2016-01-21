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
            "userName": "diwakar"
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
    
    // if alert view is to be added when the app is launched
    var shouldLoadAlertScreenOnLaunch : Bool? {
        get{
            let key = self.userDefaultForKey("shouldLoadAlertScreenOnLaunch")
            return key as? Bool
        }
        set(value){
            self.setUserDefaultValueForKey(value!, key: "shouldLoadAlertScreenOnLaunch")
        }
    }
    
    var alertTitle: String? {
        get{
            let key = self.userDefaultForKey("alertTitle")
            return key as? String
        }
        set(value) {
            self.setUserDefaultValueForKey(value!, key: "alertTitle")
        }
    }
    
    var alertMessage: String? {
        get{
            let key = self.userDefaultForKey("alertMessage")
            return key as? String
        }
        set(value) {
            self.setUserDefaultValueForKey(value!, key: "alertMessage")
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
