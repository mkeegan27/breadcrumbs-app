//
//  SettingsViewController.swift
//  Amnesia
//
//  Created by Mike Keegan on 10/8/16.
//  Copyright © 2016 mikekeegan. All rights reserved.
//

import UIKit

var savedEntriesDict = [String:String]() //maps default name to saved name

class SettingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var descSaveLabel: UILabel!
    @IBOutlet weak var savedTable: UITableView!
    
    @IBOutlet weak var segCtrl: UISegmentedControl!
    
    @IBOutlet weak var saveButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let attr = NSDictionary(object: UIFont(name: "Arial", size: 12.0)!, forKey: NSFontAttributeName as NSCopying)
        segCtrl.setTitleTextAttributes(attr as? [AnyHashable : Any], for: .normal)
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if(savedEntriesDict.count == 0){
            descSaveLabel.text = "Slide a log entry to the left to save the location under a new name!"
        }
        else{
            descSaveLabel.text = "Here are all the places you've saved."
        }
        descSaveLabel.adjustsFontSizeToFitWidth = true
        savedTable.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return savedEntriesDict.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.savedTable.dequeueReusableCell(withIdentifier: "saveCell") as! SavedTableViewCell
        //let index = savedEntriesDict.startIndex.advancedBy(indexPath.row)
        //cell.changeOGLabel(newText: "")
        cell.changeSaveLabel(newText: "\(Array(savedEntriesDict.values)[indexPath.row]):")
        cell.changeOldNameLabel(newText: Array(savedEntriesDict.keys)[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView,
                   editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .default, title: "Delete") { action, index in
            //print("Delete")
            savedEntriesDict.removeValue(forKey: Array(savedEntriesDict.keys)[indexPath.row])
            newLocations.dataPoints.remove(at: indexPath.row)
            //self.tblV.reloadData()
            //print("Delete \(newLocations.dataPoints.count)")
                self.savedTable.deleteRows(at: [indexPath], with: .fade)

            //self.tblV.reloadData()
            //delete function does not work all the time
            //also does not delete map annotations
        }
        return [delete]

            
            
        }

    @IBAction func segChanged(_ sender: UISegmentedControl) {
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
