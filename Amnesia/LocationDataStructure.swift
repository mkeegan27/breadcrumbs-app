//
//  LocationDataStructure.swift
//  Amnesia
//
//  Created by Peter Tao on 10/8/16.
//  Copyright © 2016 mikekeegan. All rights reserved.
//

import UIKit

struct Locations {
    var allLocations = [String:Int]()
    
    mutating func addLocation(location:String) {
        if allLocations[location] == nil {
            allLocations[location] = 5
        } else {
            allLocations[location] = allLocations[location]! + 5
        }
    }
}
