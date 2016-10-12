//
//  LocationDataStructure.swift
//  Amnesia
//
//  Created by Peter Tao on 10/8/16.
//  Copyright © 2016 mikekeegan. All rights reserved.
//

import UIKit
import MapKit

struct Locations {
    var allLocations = [String:Alocation]()
    var allLocations2 = [Alocation]()
    
    mutating func addLocation(location:String, timestamp:NSDate, coord:CLLocation) {
        var isAlreadyInList = false
        var locInIndex = 0
        let saveArray = valuesToArray()
        if(saveArray.count > 0){
        for el in 0...valuesToArray().count-1 {
            if(valuesToArray()[el].reg.contains(coord.coordinate)){
                isAlreadyInList = true
                locInIndex = el
            }
        }
        }
        
        if !isAlreadyInList {
            var newLocation = Alocation(seconds: 5, lastVisit: timestamp, locationName: location, loc: coord, reg: CLCircularRegion(center: coord.coordinate, radius: 0.01, identifier: location))
            /*
            newLocation.seconds = 5
            newLocation.lastVisit = timestamp
            newLocation.locationName = location
            newLocation.loc = coord
            newLocation.reg = CLCircularRegion(center: CLLocationCoordinate2D(coord), radius: 0.01, identifier: location)
            */
            allLocations[location] = newLocation
            allLocations2.append(newLocation)
        } else {
            allLocations[location]!.seconds = allLocations[location]!.seconds + 5
            allLocations2[locInIndex].seconds += 5
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
    
    func valuesToArray() -> [Alocation] {
        var stringArr: [Alocation] = []
        for value in allLocations.values {
            stringArr.append(value)
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
    var loc: CLLocation = CLLocation(latitude: 0,longitude: 0)
    var reg: CLCircularRegion
}
