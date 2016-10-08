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
    let timestamp:NSDate
    let locName:String
    init(lat:CLLocationDegrees, long:CLLocationDegrees, timestamp:NSDate, locName:String) {
        self.lat = lat
        self.long = long
        self.timestamp = timestamp
        self.locName = locName
    }
}
