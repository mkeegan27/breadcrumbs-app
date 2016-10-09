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

var selectedDataPoint:DataPoint = DataPoint(lat: 0.0, long: 0.0, timestamp: NSDate() as Date, locName: "Location")

class LogViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tblV: UITableView!
    var refreshControl: UIRefreshControl!
    
    @IBAction func unwindToTableView(segue:UIStoryboardSegue) {
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        NotificationCenter.default.post(name: stoMap, object: nil)
        
//        var dateComponents = DateComponents()
//        dateComponents.year = 2016
//        dateComponents.month = 10
//        dateComponents.day = 8
//        dateComponents.timeZone = TimeZone(abbreviation: "EST")
//        dateComponents.hour = 8
//        dateComponents.minute = 34
//        var userCalendar = Calendar.current // user calendar
//        var someDateTime = userCalendar.date(from: dateComponents)
//        
//        newLocations.addDataWithTimeframe(lat: 42.387264, long: -72.525996, timestamp: someDateTime!, locName: "Fine Arts Center", timeSp: 7320)
//        dateComponents.hour = 10
//        dateComponents.minute = 36
//        userCalendar = Calendar.current // user calendar
//        someDateTime = userCalendar.date(from: dateComponents)
//        newLocations.addDataWithTimeframe(lat: 42.392429, long: -72.524763, timestamp: someDateTime!, locName: "Integrated Sciences Building", timeSp: 3000)
//        dateComponents.hour = 11
//        dateComponents.minute = 26
//        userCalendar = Calendar.current // user calendar
//        someDateTime = userCalendar.date(from: dateComponents)
//        newLocations.addDataWithTimeframe(lat: 42.386190, long: -72.531143, timestamp: someDateTime!, locName: "Linden Hall", timeSp: 3600*3)
        tblV.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        NotificationCenter.default.post(name: staMap, object: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //LogMgr.addLoc(GPSNew: 0, locationNameNew: 0, timeBeginNew: 0, timeEndNew: 0)
        
        self.tblV.tableFooterView = UIView()
        self.tblV.separatorStyle = UITableViewCellSeparatorStyle.none

        refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "")
        refreshControl.addTarget(self, action: #selector(LogViewController.refresh), for: UIControlEvents.valueChanged)
        tblV.addSubview(refreshControl)
        
        // Do any additional setup after loading the view.
        
        
//        var longitude :CLLocationDegrees = -72.525909
//        var latitude :CLLocationDegrees = 42.391075
//        
//        var location = CLLocation(latitude: latitude, longitude: longitude) //changed!!!
//        //print(location)
//        
//        
//        CLGeocoder().reverseGeocodeLocation(location)
//        {
//            (placemarks, error) -> Void in
//            
//            let placeArray = placemarks as [CLPlacemark]!
//            
//            // Place details
//            var placeMark: CLPlacemark!
//            placeMark = placeArray?[0]
//            
//            print(ABCreateStringWithAddressDictionary(placeMark.addressDictionary!, false))
//            
            // Address dictionary
            //print(placeMark.addressDictionary)
            
//            // Location name
//            if let locationName = placeMark.addressDictionary?["Name"] as? NSString
//            {
//                print(locationName)
//            }
//            // subLocality KEY DOES NOT WORK
//            if let locality = placeMark.addressDictionary?["SubLocality"] as? NSString
//            {
//                print(locality)
//            }
//
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
//        }
    }
    
    func refresh() {
        // Code to refresh table view
        tblV.reloadData()
        self.refreshControl.endRefreshing()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return newLocations.dataPoints.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = self.tblV.dequeueReusableCell(withIdentifier: "LogCell") as! LogTableViewCell
        let timeSpent = newLocations.dataPoints[newLocations.dataPoints.count - indexPath.row - 1].timeSpent
        let timeStart = newLocations.dataPoints[newLocations.dataPoints.count - indexPath.row - 1].startTimestamp
        
        let newName = savedEntriesDict[newLocations.dataPoints[newLocations.dataPoints.count - indexPath.row - 1].locName]
        
        if (newName != nil){
            cell.changeLabelText(newText: newName!)
        }
        else{
            cell.changeLabelText(newText: newLocations.dataPoints[newLocations.dataPoints.count - indexPath.row - 1].locName)
        }
        //cell.changeTimeText(newText: getTimeLabel(secs: timeSpent))
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm"
        let str_from_date = dateFormatter.string(from: newLocations.dataPoints[newLocations.dataPoints.count - indexPath.row - 1].startTimestamp)
        cell.changeTimeText(newText: getTimeLabel(secs: timeSpent) + " from " + str_from_date + " until " + dateFormatter.string(from: timeStart.addingTimeInterval(TimeInterval(timeSpent))))
        cell.backgroundColor = UIColor(colorLiteralRed: 14/255, green: 122/255, blue: 254/255, alpha: Float(timeSpent)/Float(newLocations.longestTime)*0.8)
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {

    }
    
    func tableView(_ tableView: UITableView,
                   editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let edit = UITableViewRowAction(style: .normal, title: "Save") { action, index in
            //print("Save")
            var newSaveName: String = ""
            
            
            //1. Create the alert controller.
            var alert = UIAlertController(title: "Some Title", message: "Save \"\(newLocations.dataPoints[newLocations.dataPoints.count - indexPath.row - 1].locName)\" as what?", preferredStyle: .alert)
            
            //2. Add the text field. You can configure it however you need.
            alert.addTextField(configurationHandler: { (textField) -> Void in
                textField.text = ""
            })
            
            //3. Grab the value from the text field, and print it when the user clicks OK.
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
                let textField = alert.textFields![0] as UITextField
                newSaveName = textField.text!
                savedEntriesDict[newLocations.dataPoints[newLocations.dataPoints.count - indexPath.row - 1].locName] = newSaveName
                self.tblV.reloadData()
                //NotificationCenter.default.post(name: NSNotification.Name(rawValue: "STARTMAP"), object: nil)
                //print("Text field: \(textField.text)")
            }))
            alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { (action) -> Void in
            }))
            
            // 4. Present the alert.
            self.present(alert, animated: true, completion: nil)
            
            
        }
        let delete = UITableViewRowAction(style: .default, title: "Delete") { action, index in
            //print("Delete")
            newLocations.dataPoints.remove(at: indexPath.row)
            //self.tblV.reloadData()
            //print("Delete \(newLocations.dataPoints.count)")
            if(timeCheckInt>3){
            self.tblV.deleteRows(at: [indexPath], with: .fade)
            }
            else{
                self.tblV.reloadData()
            }
            //self.tblV.reloadData()
            //delete function does not work all the time
            //also does not delete map annotations
        }
        return [delete, edit]
//        LogMgr.logset.remove(at: indexPath.row)
//        tblV.reloadData()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dataPoint = newLocations.dataPoints[newLocations.dataPoints.count - indexPath.row - 1]
        selectedDataPoint = dataPoint
        //        map.setRegion(region, animated: false)
        performSegue(withIdentifier: "toMap", sender: self)
//        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
    }

    func getTimeLabel(secs: Int) -> String {
        if secs < 60 {
            return "\(secs) seconds"
        } else if secs < 3600 {
            if secs/60 == 1 {
                return "\(secs/60) minute"
            }
            return "\(secs/60) minutes"
        } else if secs < 3600*24 {
            if secs/3600 == 1 {
                return "\(secs/3600) hour"
            }
            return "\(secs/3600) hours"
        } else {
            if secs/3600/24 == 1 {
                return "\(secs/3600/24) day"
            }
            return "\(secs/3600/24) days"
        }
    }

    
    
}
