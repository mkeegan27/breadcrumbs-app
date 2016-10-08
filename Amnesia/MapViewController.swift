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
var newLocations = LocationData()

class MapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

    
    @IBOutlet weak var locButton: UIButton!
    
    @IBOutlet weak var map: MKMapView!
    var pinAnnotationView:MKPinAnnotationView!
    var manager:CLLocationManager!
    var setLocation: Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("in here")
        manager = CLLocationManager()
        manager.allowsBackgroundLocationUpdates = true

        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.requestAlwaysAuthorization()
        
        manager.startUpdatingLocation()
        // Do any additional setup after loading the view, typically from a nib.
        
        map.delegate = self
        map.mapType = MKMapType.standard
        map.showsUserLocation = true
        
        map.setUserTrackingMode(MKUserTrackingMode.follow, animated: true)
        setLocation = true
        
        
    }
    
    
    @IBAction func locButtonPressed(_ sender: UIButton) {
        if(setLocation){
            map.setUserTrackingMode(MKUserTrackingMode.none, animated: true)
            setLocation = false
        }
        else{
            map.setUserTrackingMode(MKUserTrackingMode.follow, animated: true)
            setLocation = true
        }
        
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
//        var locValue:CLLocationCoordinate2D = manager.location.coordinate
//        //userLocation - there is no need for casting, because we are now using CLLocation object
//        
        let userLocation:CLLocation = locations[0]
        let latitude:CLLocationDegrees = userLocation.coordinate.latitude
        let longitude:CLLocationDegrees = userLocation.coordinate.longitude
//        let latDelta:CLLocationDegrees = 0.01
//        let lonDelta:CLLocationDegrees = 0.01
//        let span:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, lonDelta)
//        let location:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
//        let region:MKCoordinateRegion = MKCoordinateRegionMake(location, span)
//        map.setRegion(region, animated: false)
        
        let location = locations.last! as CLLocation
        
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        
//        if(setLocation){
//            self.map.setRegion(region, animated: true)
//        //    setLocation = true
//        }
        
        
        for value in newLocations.dataPoints{
            
            let newCoord:CLLocation = CLLocation(latitude: value.lat, longitude: value.long)
            
            let newAnotation = MKPointAnnotation()
            newAnotation.coordinate = newCoord.coordinate
            newAnotation.title = value.locName
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "hh:mm"
            let str_from_date = dateFormatter.string(from: value.startTimestamp)
            newAnotation.subtitle = "from " + str_from_date + " until " + dateFormatter.string(from: value.startTimestamp.addingTimeInterval(TimeInterval(value.timeSpent)))
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
                    newLocations.addData(lat: location.coordinate.latitude, long: location.coordinate.longitude, timestamp: Date(), locName: thisLocation)
                    allLocations.addLocation(location: thisLocation, timestamp: NSDate(), coord: location)
					LogMgr.addLoc(locNew:location, locationNameNew: thisLocation, timeBeginNew: 0, timeEndNew: 0)
                }
                
                print(newLocations.dataPoints)
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
