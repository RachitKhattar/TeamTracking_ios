//
//  FirstViewController.swift
//  TeamTracking
//
//  Created by Rachit on 20/01/16.
//
//

import UIKit
import CoreLocation

class FirstViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var latLabel: UILabel!
    @IBOutlet weak var longLabel: UILabel!
    let locationManager = CLLocationManager()
    
    var lo1: Double = 0
    var la1: Double = 0
    var lo2: Double = 0
    var la2: Double = 0
    var long: Double = 0
    var lat: Double = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            print("enabled")
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestAlwaysAuthorization()
            locationManager.startUpdatingLocation()
        } else {
            print("not enabled")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func calcButton(sender: AnyObject?) {
        calc_distance(lo1, lat1: la1, lon2: long, lat2: lat)
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("Here")
        let userLocation:CLLocation = locations[0]
        long = userLocation.coordinate.longitude;
        lat = userLocation.coordinate.latitude;
        //Do What ever you want with it
        
        print(long)
        print(lat)
        
        latLabel.text = "\(lat)"
        longLabel.text = "\(long)"
        //        calc_distance(lo1, lat1: la1, lon2: long, lat2: lat)
        calcButton(nil)
        
    }
    
    @IBAction func captureButton(sender: UIButton) {
        lo1 = long
        la1 = lat
    }
    //    func calc_distance(lon1: Double, lat1: Double, lon2: Double, lat2: Double) {
    //
    //        let R = 6373.0
    ////        let R = 3961.0
    //        let dlon = lon2 - lon1
    //        let dlat = lat2 - lat1
    //        let a = pow((sin(dlat/2)),2) + cos(lat1) * cos(lat2) * pow((sin(dlon/2)),2)
    //        let c = 2 * atan2( sqrt(a), sqrt(1-a) )
    //        let d = R * c * 16.0934
    //        distanceLabel.text = "\(d)"
    //
    //    }
    
    func calc_distance(lon1: Double, lat1: Double, lon2: Double, lat2: Double) {
        let R = 6371.0
        let latDistance = degToRad(lat2 - lat1)
        let lonDistance = degToRad(lon2 - lon1)
        let a = sin(latDistance/2) * sin(latDistance/2) + cos(degToRad(lat1)) * cos(degToRad(lat2)) * sin(lonDistance/2) * sin(lonDistance/2)
        let c = 2 * atan2(sqrt(a), sqrt(1-a))
        let distance = R * c * 1000
        
        distanceLabel.text = "\(distance)"
        
    }
    
    func degToRad(deg: Double) -> Double {
        return deg * M_PI/180
    }
}

