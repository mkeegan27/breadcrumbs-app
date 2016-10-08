//
//  StatsViewController.swift
//  Amnesia
//
//  Created by Peter Tao on 10/8/16.
//  Copyright © 2016 mikekeegan. All rights reserved.
//

import UIKit
import Charts


class StatsViewController: UIViewController {
    @IBOutlet weak var barChartView: BarChartView!

    var dataTypes = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDataTypes()

        let unitsSold = [Double(4.0), Double(4.0), Double(10.0)]
        setChart(dataPoints: dataTypes, values: unitsSold)
        // Do any additional setup after loading the view.
    }

    func setChart(dataPoints: [String], values: [Double]){
        
        
        barChartView.noDataText = "Hi dude, there's no data"
        
        var dataEntries: [BarChartDataEntry] = []
        for i in 0..<dataPoints.count {
            let dataEntry = BarChartDataEntry(x: 3.0, yValues: [4.0,5], label: "hello")
            dataEntries.append(dataEntry)
        }
        
        let chartDataSet = BarChartDataSet(values: dataEntries, label: "Number of votes")
        let chartData = BarChartData(dataSet: chartDataSet)
        chartData.setValueFont(UIFont(name: "Avenir", size: 13))
        chartData.setValueTextColor(UIColor.white)
        //        chartData.setValueFormatter(NSNumberFormatter())
        chartData.setDrawValues(false)
        barChartView.leftAxis.axisMinValue = 0
        barChartView.data = chartData
        barChartView.descriptionText = ""
        barChartView.xAxis.labelPosition = .bottom
        barChartView.xAxis.labelFont = UIFont(name: "Avenir", size: 14)!
        barChartView.xAxis.labelTextColor = UIColor.white
        barChartView.rightAxis.enabled = false
        barChartView.legend.enabled = false
        barChartView.legend.textColor = UIColor.white
        barChartView.leftAxis.enabled = true
        barChartView.leftAxis.labelTextColor = UIColor.white
        barChartView.highlightPerTapEnabled = false
        barChartView.doubleTapToZoomEnabled = false
        barChartView.data?.highlightEnabled = false
        //        barChartView.xAxis.drawGridLinesEnabled = false
        //        barChartView.leftAxis.drawGridLinesEnabled = false
        barChartView.xAxis.gridColor = UIColor.lightGray
        barChartView.leftAxis.gridColor = UIColor.lightGray
        
        
        chartDataSet.colors = [UIColor(red: 135/255, green: 206/255, blue: 250/255, alpha: 1), UIColor(red: 1, green: 0.80, blue: 0.82, alpha: 1), UIColor.gray]
        barChartView.backgroundColor = UIColor.clear
        barChartView.animate(yAxisDuration: 2.0)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setDataTypes() {
        dataTypes = ["Male", "Female", "Other"]
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