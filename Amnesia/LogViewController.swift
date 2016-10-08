//
//  LogViewController.swift
//  Amnesia
//
//  Created by Mike Keegan on 10/8/16.
//  Copyright © 2016 mikekeegan. All rights reserved.
//

import UIKit
import MapKit
import AddressBookUI

class LogViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tblV: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        LogMgr.addLoc(GPSNew: 0, locationNameNew: 0, timeBeginNew: 0, timeEndNew: 0)
        // Do any additional setup after loading the view.
        
        
        var longitude :CLLocationDegrees = -72.525909
        var latitude :CLLocationDegrees = 42.391075
        
        var location = CLLocation(latitude: latitude, longitude: longitude) //changed!!!
        //print(location)
        
        
        CLGeocoder().reverseGeocodeLocation(location)
        {
            (placemarks, error) -> Void in
            
            let placeArray = placemarks as [CLPlacemark]!
            
            // Place details
            var placeMark: CLPlacemark!
            placeMark = placeArray?[0]
            
            print(ABCreateStringWithAddressDictionary(placeMark.addressDictionary!, false))
            
            // Address dictionary
            //print(placeMark.addressDictionary)
            
            // Location name
            if let locationName = placeMark.addressDictionary?["Name"] as? NSString
            {
                print(locationName)
            }
            
            // Street address
            if let street = placeMark.addressDictionary?["Thoroughfare"] as? NSString
            {
                print(street)
            }
            
            // City
            if let city = placeMark.addressDictionary?["City"] as? NSString
            {
                print(city)
            }
            
            // Zip code
            if let zip = placeMark.addressDictionary?["ZIP"] as? NSString
            {
                print(zip)
            }
            
            // Country
            if let country = placeMark.addressDictionary?["Country"] as? NSString
            {
                print(country)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return LogMgr.logset.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = self.tblV.dequeueReusableCell(withIdentifier: "LogCell") as! LogTableViewCell
        
        cell.changeLabelText(newText: "Test!!!")
        
        return cell
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
