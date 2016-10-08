//
//  LocationDataStructure.swift
//  Amnesia
//
//  Created by Peter Tao on 10/8/16.
//  Copyright © 2016 mikekeegan. All rights reserved.
//

import UIKit

struct Locations {
    var allLocations = [String:Alocation]()
    
    mutating func addLocation(location:String, timestamp:NSDate) {
        if allLocations[location] == nil {
            var newLocation = Alocation()
            newLocation.seconds = 5
            newLocation.lastVisit = timestamp
            allLocations[location] = newLocation
        } else {
            allLocations[location]!.seconds = allLocations[location]!.seconds + 5
        }
    }
}

struct Alocation {
    var seconds = 0
    var lastVisit:NSDate = NSDate()
}
