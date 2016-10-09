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

    @IBOutlet weak var map: MKMapView!
    @IBAction func exitAction(_ sender: AnyObject) {
        self.performSegue(withIdentifier: "unwindToTableView", sender: self)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        print(specificRegion)
        map.setRegion(specificRegion, animated: false)
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
