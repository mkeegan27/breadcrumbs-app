//
//  SettingsViewController.swift
//  Amnesia
//
//  Created by Mike Keegan on 10/8/16.
//  Copyright © 2016 mikekeegan. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var segCtrl: UISegmentedControl!
    
    @IBOutlet weak var saveButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let attr = NSDictionary(object: UIFont(name: "Arial", size: 12.0)!, forKey: NSFontAttributeName as NSCopying)
        segCtrl.setTitleTextAttributes(attr as? [AnyHashable : Any], for: .normal)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveButtonPressed(_ sender: UIButton) {
        let sel: Int = segCtrl.selectedSegmentIndex
        if(sel==0){
            timeCheckInt = 1
        }
        else if(sel==1){
            timeCheckInt = 5
        }
        else if(sel==2){
            timeCheckInt = 60
        }
        else if(sel==3){
            timeCheckInt = 120
        }
        else if(sel==4){
            timeCheckInt = 300
        }
        else if(sel==5){
            timeCheckInt = 1800
        }
        else if(sel==5){
            timeCheckInt = 3600
        }
        else{
            timeCheckInt = 7200
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
