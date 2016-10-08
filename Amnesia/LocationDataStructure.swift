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
            newLocation.locationName = location
            allLocations[location] = newLocation
        } else {
            allLocations[location]!.seconds = allLocations[location]!.seconds + 5
        }
    }
    
    func getKeys() {
        for key in allLocations.keys {
            print(key)
        }
    }
    
    func toArray() -> [String] {
        var stringArr: [String] = []
        for key in allLocations.keys {
            stringArr.append(key)
        }
        return stringArr
    }
    
    func getLocAtIndex(ind: Int) -> Alocation{
        return allLocations[self.toArray()[ind]]!
    }
    
}

struct Alocation {
    var seconds = 0
    var lastVisit:NSDate = NSDate()
    var locationName = ""
}
