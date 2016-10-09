//
//  SpecificMapViewController.swift
//  Amnesia
//
//  Created by Peter Tao on 10/8/16.
//  Copyright © 2016 mikekeegan. All rights reserved.
//

import UIKit
import MapKit

class SpecificMapViewController: UIViewController {

    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var map: MKMapView!
    @IBAction func exitAction(_ sender: AnyObject) {
        self.performSegue(withIdentifier: "unwindToTableView", sender: self)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let origImage = UIImage(named: "circleBack");
        let tintedImage = origImage?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        backButton.setImage(tintedImage, for: .normal)
        backButton.tintColor = UIColor(colorLiteralRed: 14/255, green: 122/255, blue: 254/255, alpha: 1.0)
        
        let latitude:CLLocationDegrees = selectedDataPoint.lat
        let longitude:CLLocationDegrees = selectedDataPoint.long
        let latDelta:CLLocationDegrees = 0.05
        let lonDelta:CLLocationDegrees = 0.05
        let span:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, lonDelta)
        let location:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
        let region:MKCoordinateRegion = MKCoordinateRegionMake(location, span)
        
        let newCoord:CLLocation = CLLocation(latitude: region.center.latitude, longitude: region.center.longitude)
        let newAnotation = MKPointAnnotation()
        newAnotation.coordinate = newCoord.coordinate
        newAnotation.title = selectedDataPoint.locName
        map.addAnnotation(newAnotation)
        map.setRegion(region, animated:false)
        //        if(setLocation){
        //            self.map.setRegion(region, animated: true)
        //        //    setLocation = true
        //        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
