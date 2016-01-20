//
//  FirstViewController.swift
//  TeamTracking
//
//  Created by Rachit on 20/01/16.
//
//

import UIKit

class FirstViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(animated: Bool) {
        // TODO: uncomment below section to load radar controller
        /*
        let bundle = NSBundle(forClass: self.dynamicType)
        let nib = UINib(nibName: "RadarViewController", bundle: bundle)
        let monitorViewController = nib.instantiateWithOwner(self, options: nil)[0] as! UIViewController
        presentViewController(monitorViewController, animated: true, completion: nil)
        */
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

