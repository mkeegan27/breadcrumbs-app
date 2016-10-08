//
//  MapViewController.swift
//  Amnesia
//
//  Created by Peter Tao on 10/8/16.
//  Copyright © 2016 mikekeegan. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

    
    
    @IBOutlet weak var map: MKMapView!
    
    var manager:CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("in here")
        manager = CLLocationManager()
        manager.allowsBackgroundLocationUpdates = true

        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        //        manager.requestAlwaysAuthorization()
        
        manager.startUpdatingLocation()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        print(locations)
        
        //userLocation - there is no need for casting, because we are now using CLLocation object
        
        let userLocation:CLLocation = locations[0]
        let latitude:CLLocationDegrees = userLocation.coordinate.latitude
        let longitude:CLLocationDegrees = userLocation.coordinate.longitude
        let latDelta:CLLocationDegrees = 0.01
        let lonDelta:CLLocationDegrees = 0.01
        let span:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, lonDelta)
        let location:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
        let region:MKCoordinateRegion = MKCoordinateRegionMake(location, span)
        map.setRegion(region, animated: false)
        
        
        
        var newLocation = CLLocation(latitude: latitude, longitude: longitude)
        
        //        var testLocation = CLLocation(latitude: 42.373222, longitude: -72.519854)
        
        var testLocation = CLLocation(latitude: 42.386809, longitude: -72.525473)
        //        42.386809, -72.525473
        CLGeocoder().reverseGeocodeLocation(testLocation, completionHandler: {(placemarks, error) -> Void in
            print(location)
            
            if error != nil {
                print("Reverse geocoder failed with error" + (error?.localizedDescription)!)
                return
            }
            
            if (placemarks?.count)! > 0 {
                let pm = placemarks![0]
                print(pm.locality)
            }
            else {
                print("Problem with the data received from geocoder")
            }
        })
        
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
