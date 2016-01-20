//
//  User.swift
//  TeamTracking
//
//  Created by Rachit on 20/01/16.
//
//

import UIKit

class User: NSObject {
    var name = String()
    var latitude = Double()
    var longitude = Double()
    var distance = Int()
    var available = Bool()
    var color = UIColor()
    
    func compareByDistance(other : User) -> NSComparisonResult {
        let firstDistance = self.distance
        let otherDistance = self.distance
        var result : NSComparisonResult = NSComparisonResult.OrderedAscending
        if (firstDistance > otherDistance)
        {
            result = .OrderedDescending;
        }
        return result
    }
}
