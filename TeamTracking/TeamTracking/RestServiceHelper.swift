//
//  RestServiceHelper.swift
//  TeamTracking
//
//  Created by Diwakar Kamboj on 20/01/16.
//
//

import UIKit
import Alamofire

class RestServiceHelper: NSObject {
    
    func trackLocation(completion: (result: Bool) -> Void) {
        let url = "\(Constants.host_address)/teamtracking/rest/location/tracklocation/\(AppContext.sharedInstance.lat)/\(AppContext.sharedInstance.long)/\(AppSettings.sharedInstance.userName)/"
        
        Alamofire.request(.GET, url)
            .responseJSON { response in
                
                var success = false
                
                if let receivedValue = response.result.value {
                    let errorCode = receivedValue.objectForKey("errorCode") as! Int
                    
                    if (errorCode == 200) {
                        success = true
                        AppContext.sharedInstance.roomNumber = receivedValue.objectForKey("roomNumber") as! Int
                    }
                }
                completion(result: success)
        }
    }
    
    func pushAccepted(completion: (result: Bool) -> Void) {
        let url = "\(Constants.host_address)/teamtracking/rest/location/pushaccepted/\(AppContext.sharedInstance.lat)/\(AppContext.sharedInstance.long)/\(AppSettings.sharedInstance.userName)/\(AppContext.sharedInstance.roomNumber)/"
        Alamofire.request(.GET, url)
            .responseJSON { response in
                
                var success = false
                
                if let _ = response.result.value {
                    success = true
                }
                completion(result: success)
        }
    }
    
    func checkLocation(completion: (result: Bool) -> Void) {
        let url = "\(Constants.host_address)/teamtracking/rest/location/checklocation/\(AppContext.sharedInstance.roomNumber)/\(AppSettings.sharedInstance.userName)/"
        
        Alamofire.request(.GET, url)
            .responseJSON { response in
                
                var success = false
                
                if let receivedValue = response.result.value {
                    success = true
                    
                    let usersDict = AppContext.sharedInstance.users
                    
                    let locationsArray = receivedValue.objectForKey("locations") as! [AnyObject]
                    
                    for receivedUser in locationsArray {
                        let selectUser = usersDict[receivedUser.objectForKey("userName") as! String]
                        selectUser?.longitude = receivedUser.objectForKey("longitude") as! Double
                        selectUser?.latitude = receivedUser.objectForKey("latitude") as! Double
                        selectUser?.available = true
                        selectUser?.distance = receivedUser.objectForKey("distance") as! Double
                    }
                    
                }
                completion(result: success)
        }
    }
    
}
