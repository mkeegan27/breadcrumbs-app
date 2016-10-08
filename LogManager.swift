//
//  LogManager.swift
//  Amnesia
//
//  Created by Mike Keegan on 10/8/16.
//  Copyright © 2016 mikekeegan. All rights reserved.
//

import UIKit
import MapKit

//this object will hold an array of all locations for a day
var LogMgr:LogManager = LogManager()


//this struct defines one location in the log
struct Location{
    var location: CLLocation
    var locationName = "test name"
    var timeBegin = 0
    var timeEnd = 0
    
}

class LogManager: NSObject {
    
    var logset = [Location]()
    
    //will update these types to be more appropriate once it works
    func addLoc(locNew:CLLocation, locationNameNew: String, timeBeginNew: Int, timeEndNew: Int){
        logset.append(Location(location:locNew, locationName: locationNameNew, timeBegin: timeBeginNew, timeEnd: timeEndNew))
    }

}
