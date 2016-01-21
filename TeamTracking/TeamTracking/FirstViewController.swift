//
//  FirstViewController.swift
//  TeamTracking
//
//  Created by Rachit on 20/01/16.
//
//

import UIKit

class FirstViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,CLLocationManagerDelegate {
    
    @IBOutlet weak var startTrackingButton: UIButton!
    @IBOutlet weak var usersTableView: UITableView!
    @IBOutlet weak var radarViewButton: UIButton!
    let otherUserKeys = NSMutableArray()
    
    let locationManager = CLLocationManager()
    
    var streamTimer: NSTimer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        usersTableView.registerNib(UINib(nibName: "LocationTableViewCell", bundle: nil), forCellReuseIdentifier: "LocationTableViewCellIdentifier")
//        self.refreshDataSource()
        // Do any additional setup after loading the view, typically from a nib.
        
        // On initial state
        showUsers(false)
//        AppSettings.sharedInstance.userName = "rachit"
//        
//        AppContext.sharedInstance.lat = 28.11111
//        AppContext.sharedInstance.long = 124.22222
//        
//        
//        let serviceHelper = RestServiceHelper()
//        serviceHelper.trackLocation() { (result) -> Void in
//            if (result) {
//                print("success")
//                self.usr2()
//            } else {
//                print("failure")
//            }
//        }
        
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            print("enabled")
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.requestAlwaysAuthorization()
            locationManager.startUpdatingLocation()
//            locationManager.requestLocation()
        } else {
            print("not enabled")
        }
        
        
    }
    
    override func viewDidDisappear(animated: Bool) {
//        streamTimer.invalidate()
        locationManager.stopUpdatingLocation()
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("Here")
        let userLocation:CLLocation = locations[0]
        let long = userLocation.coordinate.longitude;
        let lat = userLocation.coordinate.latitude;
        
        AppContext.sharedInstance.long = long
        AppContext.sharedInstance.lat = lat
        
        print(AppContext.sharedInstance.long)
        print(AppContext.sharedInstance.lat)
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print(error)
    }
    
//    func usr2() {
//        AppContext.sharedInstance.lat = 12.3333
//        AppContext.sharedInstance.long = 109.4444
//        AppSettings.sharedInstance.userName = "diwakar"
//        
//        
//        let serviceHelper = RestServiceHelper()
//        serviceHelper.pushAccepted() { (result) -> Void in
//            if (result) {
//                print("push success")
//                self.checkL()
//            } else {
//                print("push failure")
//            }
//        }
//        
//    }
    
//    func checkL() {
//        
//        let serviceHelper = RestServiceHelper()
//        serviceHelper.checkLocation() { (result) -> Void in
//            if (result) {
//                print("check success")
//            } else {
//                print("check failure")
//            }
//        }
//    }
    
    func refreshDataSource() {
        otherUserKeys.removeAllObjects()
        for key in AppContext.sharedInstance.users.keys {
            let user = AppContext.sharedInstance.users["\(key)"]
            if (user!.name != AppSettings.sharedInstance.userName) {
                otherUserKeys.addObject(key)
            }
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        if(AppSettings.sharedInstance.shouldLoadAlertScreenOnLaunch == true){
            AppSettings.sharedInstance.shouldLoadAlertScreenOnLaunch = false
            displayAlert()
        }
    }
    
    func displayAlert() {
        let alertController = UIAlertController(title: AppSettings.sharedInstance.alertTitle, message: AppSettings.sharedInstance.alertMessage, preferredStyle: .Alert)
        
        let shareHandler = { (action:UIAlertAction!) -> Void in
            // add command to send push response..
            
            let serviceHelper = RestServiceHelper()
            
            serviceHelper.pushAccepted() { (result) -> Void in
                if (result) {
                    print("accept success")
                    self.checkLoc()
                    self.showUsers(true)
                } else {
                    print("accepts failure")
                }
            }
        }
        
        let defaultAction = UIAlertAction(title: "Share", style: .Default, handler: shareHandler)
        let secondAction =  UIAlertAction(title: "Deny", style: .Default, handler: nil)
        alertController.addAction(secondAction)
        alertController.addAction(defaultAction)
        
        presentViewController(alertController, animated: true, completion: nil)
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func openRadarView(sender: AnyObject) {
        // TODO: uncomment below section to load radar controller
        
        let bundle = NSBundle(forClass: self.dynamicType)
        let nib = UINib(nibName: "RadarViewController", bundle: bundle)
        let monitorViewController = nib.instantiateWithOwner(self, options: nil)[0] as! UIViewController
//        let monitorViewControllerWithNavBar = UINavigationController(rootViewController: monitorViewController)
        self.navigationController!.pushViewController(monitorViewController, animated: true)
//        self.navigationController!.presentViewController(monitorViewControllerWithNavBar, animated: true, completion: nil)
        
    }
    
    // MARK: - TableView DataSource Methods
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return otherUserKeys.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("LocationTableViewCellIdentifier", forIndexPath: indexPath) as! LocationTableViewCell
        let key = otherUserKeys.objectAtIndex(indexPath.row)
        let user = AppContext.sharedInstance.users["\(key)"]
        cell.user = user
        return cell
    }
    
    @IBAction func startTrackingButtonAction(sender: AnyObject) {
        // Make call to start tracking
        
        
        let serviceHelper = RestServiceHelper()
        serviceHelper.trackLocation() { (result) -> Void in
            if (result) {
                print("success")
                self.checkLoc()
                self.showUsers(true)
            } else {
                print("failure")
            }
        }
        
        // On success
        //showUsers(true)
    }
    
    func checkLoc() {
        
        let serviceHelper = RestServiceHelper()
        serviceHelper.checkLocation() { (result) -> Void in
            if (result) {
                print("check success")
                self.refreshDataSource()
                self.usersTableView.reloadData()

//                self.startUpdatingLocationsInTable()
                
                self.streamTimer = NSTimer.scheduledTimerWithTimeInterval(5, target: self, selector: "startUpdatingLocationsInTable", userInfo: nil, repeats: true)
            } else {
                print("check failure")
            }
        }
    }
    
    func startUpdatingLocationsInTable() {
        let serviceHelper = RestServiceHelper()
        
        serviceHelper.checkLocation() { (result) -> Void in
            if (result) {
                print("check success")
                print("streaming")
                self.refreshDataSource()
                self.usersTableView.reloadData()
            } else {
                print("check failure")
            }
        }
        
    }
    
    func showUsers(show : Bool) {
        self.usersTableView.hidden = !show
        self.radarViewButton.hidden = !show
        self.startTrackingButton.hidden = show
    }
}

