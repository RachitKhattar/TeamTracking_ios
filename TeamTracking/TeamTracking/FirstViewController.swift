//
//  FirstViewController.swift
//  TeamTracking
//
//  Created by Rachit on 20/01/16.
//
//

import UIKit

class FirstViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var startTrackingButton: UIButton!
    @IBOutlet weak var usersTableView: UITableView!
    @IBOutlet weak var radarViewButton: UIButton!
    let otherUserKeys = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        usersTableView.registerNib(UINib(nibName: "LocationTableViewCell", bundle: nil), forCellReuseIdentifier: "LocationTableViewCellIdentifier")
        self.refreshDataSource()
        // Do any additional setup after loading the view, typically from a nib.
        
        // On initial state
        showUsers(false)
    }
    
    func refreshDataSource() {
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
        
        // On success
        //showUsers(true)
    }
    
    func showUsers(show : Bool) {
        self.usersTableView.hidden = !show
        self.radarViewButton.hidden = !show
        self.startTrackingButton.hidden = show
    }
}

