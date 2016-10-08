//
//  LogManager.swift
//  Amnesia
//
//  Created by Mike Keegan on 10/8/16.
//  Copyright © 2016 mikekeegan. All rights reserved.
//

import UIKit

//this object will hold an array of all locations for a day
var LogMgr:LogManager = LogManager()


//this struct defines one location in the log
struct Location{
    var GPS = 0
    var locationName = 0
    var timeBegin = 0
    var timeEnd = 0
    
}

class LogManager: NSObject {
    
    var logset = [Location]()
    
    //will update these types to be more appropriate once it works
    func addLoc(GPSNew: Int, locationNameNew: Int, timeBeginNew: Int, timeEndNew: Int){
        logset.append(Location(GPS: GPSNew, locationName: locationNameNew, timeBegin: timeBeginNew, timeEnd: timeEndNew))
    }

}
