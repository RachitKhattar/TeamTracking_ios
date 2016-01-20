//
//  AppDelegate.swift
//  TeamTracking
//
//  Created by Rachit on 20/01/16.
//
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        // Register for Remote Notifications
        let settings = UIUserNotificationSettings(forTypes: [.Alert, .Badge, .Sound], categories: nil)
        UIApplication.sharedApplication().registerUserNotificationSettings(settings)
        UIApplication.sharedApplication().registerForRemoteNotifications()
        
        setupUsersDictionary()
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
        print("Did Register for Remote Notifications with Device Token \(deviceToken))")
        // set the push token
        let characterSet: NSCharacterSet = NSCharacterSet( charactersInString: "<>" )
        let deviceTokenString: String = ( deviceToken.description as NSString )
            .stringByTrimmingCharactersInSet( characterSet )
            .stringByReplacingOccurrencesOfString( " ", withString: "" ) as String
        print("Without Spaces: \(deviceTokenString)")
    }
    
    func application(application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: NSError) {
        print("Failed to register for Remote Notifications with Error:\(error.localizedDescription)")
    }
    
    func setupUsersDictionary() {
        let userOne = User()
        userOne.name = "Parveen"
        userOne.color = UIColor.redColor()
        userOne.available = false
        
        let userTwo = User()
        userTwo.name = "Sorabh"
        userTwo.color = UIColor.greenColor()
        userTwo.available = false
        
        let userThree = User()
        userThree.name = "Diwakar"
        userThree.color = UIColor.blueColor()
        userThree.available = false
        
        let userFour = User()
        userFour.name = "Rachit"
        userFour.color = UIColor.magentaColor()
        userFour.available = false
        
        AppContext.sharedInstance.users["parveen"] = userOne
        AppContext.sharedInstance.users["sorabh"] = userTwo
        AppContext.sharedInstance.users["diwakar"] = userThree
        AppContext.sharedInstance.users["rachit"] = userFour
    }


}

