//
//  FirstViewController.swift
//  TeamTracking
//
//  Created by Rachit on 20/01/16.
//
//

import UIKit

class FirstViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var usersTableView: UITableView!
    let otherUserKeys = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        usersTableView.registerNib(UINib(nibName: "LocationTableViewCell", bundle: nil), forCellReuseIdentifier: "LocationTableViewCellIdentifier")
        self.refreshDataSource()
        // Do any additional setup after loading the view, typically from a nib.
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
        let monitorViewControllerWithNavBar = UINavigationController(rootViewController: monitorViewController)
        self.navigationController!.presentViewController(monitorViewControllerWithNavBar, animated: true, completion: nil)
        
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
}

