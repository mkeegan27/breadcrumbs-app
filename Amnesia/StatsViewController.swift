//
//  StatsViewController.swift
//  Amnesia
//
//  Created by Peter Tao on 10/8/16.
//  Copyright © 2016 mikekeegan. All rights reserved.
//

import UIKit
import Charts


class StatsViewController: UIViewController, ChartViewDelegate {
    @IBOutlet weak var barChartView: BarChartView!

    var dataTypes = [String]()
    var data = [Double]()
    var colors = [UIColor]()
    
    var newData = [barChartDataPoint]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        barChartView.delegate = self
//        setChartData()
//        setChart(dataPoints: dataTypes, values: data)
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        dataTypes = [String]()
        data = [Double]()
        colors = [UIColor]()
        setChartData()
        setChart(dataPoints: newData)
        
    }
    
    
    func setChart(dataPoints: [barChartDataPoint]){
        
        
        barChartView.noDataText = "Hi dude, there's no data"
        
        var dataEntries: [BarChartDataEntry] = []
        for i in 0..<dataPoints.count {
            let newDataEntry = BarChartDataEntry()
            let dataEntry = BarChartDataEntry(x: Double(i), yValues: [newData[i].data], label: newData[i].dataType)
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
//        barChartView.xAxis.labelPosition = .bottom
//        barChartView.xAxis.labelFont = UIFont(name: "Avenir", size: 14)!
//        barChartView.xAxis.labelTextColor = UIColor.black
        barChartView.xAxis.enabled = false
        barChartView.rightAxis.enabled = false
        barChartView.legend.enabled = false
        barChartView.legend.textColor = UIColor.black
        barChartView.leftAxis.enabled = true
        barChartView.leftAxis.labelTextColor = UIColor.black
        barChartView.highlightPerTapEnabled = true
        barChartView.doubleTapToZoomEnabled = false
        barChartView.data?.highlightEnabled = true
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
        
        for dataPoint in newLocations.dataPoints {
            dataTypes.append(dataPoint.locName)
            data.append(Double(dataPoint.timeSpent))
            newData.append(barChartDataPoint(dataType: dataPoint.locName,data: Double(dataPoint.timeSpent)))
        }
        newData.sort { (data1, data2) -> Bool in
            return data1.data < data2.data
        }
        setColors(i: newData.count)
    }
    
    func setColors(i:Int) {
        if i == 0 {
            colors.append(UIColor.black)
        } else {
            for x in 1...i {
                colors.append(UIColor(colorLiteralRed: 14/255, green: 122/255, blue: 254/255, alpha: Float(x)/Float(i)))
            }
        }
        
    }
    
    func chartValueSelected(chartView: ChartViewBase, entry: ChartDataEntry, dataSetIndex: Int, highlight: Highlight) {
        print("hello world")
    }
    
    struct barChartDataPoint {
        var dataType = ""
        var data:Double = 0.0
        init(dataType:String, data:Double) {
            self.data = data
            self.dataType = dataType
        }
    }

}
