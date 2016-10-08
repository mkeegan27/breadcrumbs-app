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
    var data = [Double]()
    var colors = [UIColor]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        setChartData()
//        setChart(dataPoints: dataTypes, values: data)
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        dataTypes = [String]()
        data = [Double]()
        colors = [UIColor]()
        setChartData()
        setChart(dataPoints: dataTypes, values: data)
    }
    
    
    func setChart(dataPoints: [String], values: [Double]){
        
        
        barChartView.noDataText = "Hi dude, there's no data"
        
        var dataEntries: [BarChartDataEntry] = []
        print(dataPoints.count)
        for i in 0..<dataPoints.count {
            let newDataEntry = BarChartDataEntry()
            let dataEntry = BarChartDataEntry(x: Double(i), yValues: [data[i]], label: dataTypes[i])
            dataEntries.append(dataEntry)
        }
        let chartDataSet = BarChartDataSet(values: dataEntries, label: "Number of votes")
        let chartData = BarChartData(dataSet: chartDataSet)
        chartData.setValueFont(UIFont(name: "Avenir", size: 13))
        chartData.setValueTextColor(UIColor.black)
        //        chartData.setValueFormatter(NSNumberFormatter())
        chartData.setDrawValues(false)
        barChartView.leftAxis.axisMinValue = 0
        barChartView.data = chartData
        barChartView.descriptionText = ""
        barChartView.xAxis.labelPosition = .bottom
        barChartView.xAxis.labelFont = UIFont(name: "Avenir", size: 14)!
        barChartView.xAxis.labelTextColor = UIColor.black
        barChartView.rightAxis.enabled = false
        barChartView.legend.enabled = false
        barChartView.legend.textColor = UIColor.black
        barChartView.leftAxis.enabled = true
        barChartView.leftAxis.labelTextColor = UIColor.black
        barChartView.highlightPerTapEnabled = false
        barChartView.doubleTapToZoomEnabled = false
        barChartView.data?.highlightEnabled = false
        //        barChartView.xAxis.drawGridLinesEnabled = false
        //        barChartView.leftAxis.drawGridLinesEnabled = false
        barChartView.xAxis.gridColor = UIColor.lightGray
        barChartView.leftAxis.gridColor = UIColor.lightGray
        
        
        chartDataSet.colors = colors
        barChartView.backgroundColor = UIColor.clear
        barChartView.animate(yAxisDuration: 2.0)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setChartData() {
        
        for dataPoint in allLocations.allLocations.values {
            dataTypes.append(dataPoint.locationName)
            data.append(Double(dataPoint.seconds))
        }
        setColors(i: allLocations.allLocations.count)
    }
    
    func setColors(i:Int) {
        if i == 0 {
            colors.append(UIColor.black)
        } else {
            for x in 1...i {
                let value = 1.0 - Double(x)/Double(i)
                colors.append(UIColor(white: CGFloat(value), alpha: 1.0))
            }
        }
        
    }

}
