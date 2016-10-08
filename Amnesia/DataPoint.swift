//
//  DataPoint.swift
//  Amnesia
//
//  Created by Peter Tao on 10/8/16.
//  Copyright © 2016 mikekeegan. All rights reserved.
//

import UIKit
import MapKit

struct DataPoint {
    let lat:CLLocationDegrees
    let long:CLLocationDegrees
    let startTimestamp:NSDate
    let locName:String
    var timeSpent:Int
    init(lat:CLLocationDegrees, long:CLLocationDegrees, timestamp:NSDate, locName:String) {
        self.lat = lat
        self.long = long
        self.startTimestamp = timestamp
        self.locName = locName
        timeSpent = 1
    }
}

struct LocationData {
    var dataPoints = [DataPoint]()
    var longestTime = 1
    mutating func addData(lat:CLLocationDegrees, long:CLLocationDegrees, timestamp:NSDate, locName:String) {
        if dataPoints.count > 0 {
            if dataPoints.last!.locName == locName {
                var last = dataPoints.removeLast()
                last.timeSpent += 1
                if last.timeSpent > longestTime {
                    longestTime = last.timeSpent
                }
                dataPoints.append(last)
                return
            }
        }
        dataPoints.append(DataPoint(lat: lat, long: long, timestamp: timestamp, locName: locName))
    }
    

}
