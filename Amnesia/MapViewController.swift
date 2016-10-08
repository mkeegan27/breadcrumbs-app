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

var allLocations = Locations()
var dataPoints = [DataPoint]()

class MapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

    
    @IBOutlet weak var map: MKMapView!
    var pinAnnotationView:MKPinAnnotationView!
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
        
        map.delegate = self
        map.mapType = MKMapType.standard
        map.showsUserLocation = true

    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        //userLocation - there is no need for casting, because we are now using CLLocation object
        
        let userLocation:CLLocation = locations[0]
        let latitude:CLLocationDegrees = userLocation.coordinate.latitude
        let longitude:CLLocationDegrees = userLocation.coordinate.longitude
        let latDelta:CLLocationDegrees = 0.01
        let lonDelta:CLLocationDegrees = 0.01
        let span:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, lonDelta)
        let location:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
        let region:MKCoordinateRegion = MKCoordinateRegionMake(location, span)
//        map.setRegion(region, animated: false)
        
        
        for value in allLocations.allLocations.values{
            
            var newCoord:CLLocation = value.loc
            
            var newAnotation = MKPointAnnotation()
            newAnotation.coordinate = newCoord.coordinate
            newAnotation.title = value.locationName
            newAnotation.subtitle = String(value.seconds)
            map.addAnnotation(newAnotation)
        }
        
        reverseGeoCode(location: CLLocation(latitude: latitude, longitude: longitude))
        
    }
    
    
    
    // this function will ouput the location as a string
    func reverseGeoCode(location: CLLocation) {

        CLGeocoder().reverseGeocodeLocation(location)
        {
            (placemarks, error) -> Void in
            
            let placeArray = placemarks as [CLPlacemark]!
            
            // Place details
            var placeMark: CLPlacemark!
            placeMark = placeArray?[0]
            if placeMark == nil {
                return
            }
            
            var thisLocation = ""
            // Location name
            if let locationName = placeMark.addressDictionary?["Name"] as? String
            {
                thisLocation = locationName
                if thisLocation != "" {
                    dataPoints.append(DataPoint(lat: location.coordinate.latitude, long: location.coordinate.longitude, timestamp: NSDate(), locName: locationName))
                    allLocations.addLocation(location: thisLocation, timestamp: NSDate(), coord: location)
					LogMgr.addLoc(locNew:location, locationNameNew: thisLocation, timeBeginNew: 0, timeEndNew: 0)

                }
                
                print(allLocations.allLocations)
            }
//            // Street address
//            if let street = placeMark.addressDictionary?["Thoroughfare"] as? NSString
//            {
//                print(street)
//            }
//            
//            // City
//            if let city = placeMark.addressDictionary?["City"] as? NSString
//            {
//                print(city)
//            }
//            
//            // Zip code
//            if let zip = placeMark.addressDictionary?["ZIP"] as? NSString
//            {
//                print(zip)
//            }
//            
//            // Country
//            if let country = placeMark.addressDictionary?["Country"] as? NSString
//            {
//                print(country)
//            }
            
            
        }
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


// old geocode data
/*
 //        CLGeocoder().reverseGeocodeLocation(testLocation, completionHandler: {(placemarks, error) -> Void in
 //            print(location)
 //
 //            if error != nil {
 //                print("Reverse geocoder failed with error" + (error?.localizedDescription)!)
 //                return
 //            }
 //
 //            if (placemarks?.count)! > 0 {
 //                let pm = placemarks![0]
 //                print(pm.locality)
 //            }
 //            else {
 //                print("Problem with the data received from geocoder")
 //            }
 //        })
 */
