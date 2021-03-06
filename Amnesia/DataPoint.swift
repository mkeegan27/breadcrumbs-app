//
//  DataPoint.swift
//  Amnesia
//
//  Created by Peter Tao on 10/8/16.
//  Copyright © 2016 mikekeegan. All rights reserved.
//

import UIKit
import MapKit

var timeCheckInt: Int = 1

struct DataPoint {
    let lat:CLLocationDegrees
    let long:CLLocationDegrees
    let reg:CLCircularRegion
    let startTimestamp:Date
    let locName:String
    var timeSpent:Int
    init(lat:CLLocationDegrees, long:CLLocationDegrees, timestamp:Date, locName:String) {
        self.lat = lat
        self.long = long
        self.startTimestamp = timestamp
        self.locName = locName
        timeSpent = timeCheckInt
        reg = CLCircularRegion(center: CLLocationCoordinate2D.init(latitude: lat, longitude: long), radius: 160, identifier: locName)
    }
    init(lat:CLLocationDegrees, long:CLLocationDegrees, timestamp:Date, locName:String, timeSp:Int) {
        self.lat = lat
        self.long = long
        self.startTimestamp = timestamp
        self.locName = locName
        timeSpent = timeSp
        reg = CLCircularRegion(center: CLLocationCoordinate2D.init(latitude: lat, longitude: long), radius: 160, identifier: locName)
    }
}

struct LocationData {
    var dataPoints = [DataPoint]()
    var longestTime = 1
    mutating func addData(lat:CLLocationDegrees, long:CLLocationDegrees, timestamp:Date, locName:String) {
        if dataPoints.count > 0 {
            if dataPoints.last!.reg.contains(CLLocationCoordinate2D.init(latitude: lat, longitude: long)) {
                var last = dataPoints.removeLast()
                last.timeSpent += timeCheckInt
                //print("\n" + String(timeCheckInt) + "\n\n\n\n")
                if last.timeSpent > longestTime {
                    longestTime = last.timeSpent
                }
                dataPoints.append(last)
                return
            }
        }
        dataPoints.append(DataPoint(lat: lat, long: long, timestamp: timestamp, locName: locName))
    }
    mutating func addDataWithTimeframe(lat:CLLocationDegrees, long:CLLocationDegrees, timestamp:Date, locName:String, timeSp:Int){
        dataPoints.append(DataPoint(lat: lat, long: long, timestamp: timestamp, locName: locName, timeSp:timeSp))
    }
    

}
