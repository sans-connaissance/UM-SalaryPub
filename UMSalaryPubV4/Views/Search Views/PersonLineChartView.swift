//
//  PersonLineChartOne.swift
//  UMICHSalaryPub (iOS)
//
//  Created by David Malicke on 3/14/21.
//

import SwiftUI
import Charts

struct PersonLineChartView: UIViewRepresentable {
    
    let personCount: Int
    let titleCount: Int
    let departmentCount: Int
    let campusCount: Int
    
    @Binding  var showTitleAverage: Bool
    @Binding  var showDepartmentAverage: Bool
    @Binding  var showCampusAverage: Bool
    @Binding  var showAnnualFTR: Bool
    
    let lineChart = LineChartView()
    let personEntryAnnualFTR: [ChartDataEntry]
    let personEntryTitleAverageAnnual: [ChartDataEntry]
    let personEntryDepartmentAverageAnnual: [ChartDataEntry]
    let personEntryCampusAverageAnnual: [ChartDataEntry]
    
    
    
    func makeUIView(context: Context) -> LineChartView {
        return lineChart
    }
    
    func updateUIView(_ uiView: LineChartView, context: Context) {
        
        setChartData(uiView)
        configureChart(uiView)
        
        formatXAxis(xAxis: uiView.xAxis)
        formatLeftAxis(leftAxis: uiView.leftAxis)
        
        
        uiView.notifyDataSetChanged()
    }
    
    func setChartData(_ lineChart: LineChartView) {
        
        let personSetAnnualFTR = LineChartDataSet(entries: personEntryAnnualFTR)
        let personSetTitleAverageAnnual = LineChartDataSet(entries: personEntryTitleAverageAnnual)
        let personSetDepartmentAverageAnnual = LineChartDataSet(entries: personEntryDepartmentAverageAnnual)
        let personSetCampusAverageAnnual = LineChartDataSet(entries: personEntryCampusAverageAnnual)
        
        //this is what needs to change in order to update the lines!
        
        
        func createDataSets(showTitleAverage: Bool, showDepartmentAverage: Bool, showCampusAverage: Bool, showAnnualFTR: Bool) -> [LineChartDataSet] {
            
            var dataSets: [LineChartDataSet] = []
            
            if showAnnualFTR == true {
                
                dataSets.append(personSetAnnualFTR)
            }
            
            if showTitleAverage == true {
                
                dataSets.append(personSetTitleAverageAnnual)
            }
            
            if showDepartmentAverage == true {
                
                dataSets.append(personSetDepartmentAverageAnnual)
            }
            
            if showCampusAverage == true {
                
                dataSets.append(personSetCampusAverageAnnual)
            }
            
            if showTitleAverage == false && showDepartmentAverage == false && showCampusAverage == false && showAnnualFTR == false {
                dataSets.append(personSetAnnualFTR)
            }
            
            return dataSets
        }
        
        
        let lineChartData = LineChartData(dataSets: createDataSets(showTitleAverage: showTitleAverage, showDepartmentAverage: showDepartmentAverage, showCampusAverage: showCampusAverage, showAnnualFTR: showAnnualFTR))
        
        lineChart.data = lineChartData
        formatDataSet(dataSet: personSetAnnualFTR, label: "Annual FTR", color: .systemGreen)
        formatDataSet(dataSet: personSetCampusAverageAnnual, label: "Campus Average FTR", color: .systemBlue)
        formatDataSet(dataSet: personSetDepartmentAverageAnnual, label: "Department Average FTR", color: .systemIndigo)
        formatDataSet(dataSet: personSetTitleAverageAnnual, label: "Title Average FTR", color: .systemOrange)
        
        
        
    }
    
    func formatDataSet(dataSet: LineChartDataSet, label: String, color: UIColor) {
        
        dataSet.label = label
        dataSet.colors = [color]
        dataSet.valueColors = [color]
        dataSet.circleColors = [color]
        dataSet.circleRadius = 4
        dataSet.circleHoleRadius = 0
        dataSet.lineWidth = 4
        dataSet.lineDashLengths = [3]
        let format = NumberFormatter()
        format.numberStyle = .currency
        format.currencySymbol = "$"
        dataSet.valueFormatter = DefaultValueFormatter(formatter: format)
        //        dataSet.valueFont = UIFont.systemFont(ofSize: 12)
        
        
    }
    func configureChart(_ lineChart: LineChartView) {
        lineChart.noDataText = "No Data"
        lineChart.drawGridBackgroundEnabled = false
        lineChart.gridBackgroundColor = UIColor.tertiarySystemFill
        lineChart.drawBordersEnabled = true
        lineChart.rightAxis.enabled = false
        lineChart.leftAxis.enabled = true
        lineChart.xAxis.enabled = true
        lineChart.legend.enabled = false
        lineChart.highlightPerTapEnabled = false
        lineChart.highlightPerDragEnabled = false
        
        
        lineChart.setScaleEnabled(false)
        if lineChart.scaleX == 1.0 {
            lineChart.zoom(scaleX: 1.0, scaleY: 1.0, x: 0, y: 0)
        }
        //            lineChart.animate(xAxisDuration: 0, yAxisDuration: 0.5, easingOption: .linear)
        
        //I think all of this can be removed.
        //        let marker:BalloonMarker = BalloonMarker(color: UIColor.red, font: UIFont(name: "Helvetica", size: 12)!, textColor: UIColor.white, insets: UIEdgeInsets(top: 7.0, left: 7.0, bottom: 7.0, right: 7.0))
        //        marker.minimumSize = CGSize(width: 75, height: 35)
        //        lineChart.marker = marker
    }
    
    
    
    //    @Binding  var showTitleAverage: Bool
    //    @Binding  var showDepartmentAverage: Bool
    //    @Binding  var showCampusAverage: Bool
    //    @Binding  var showAnnualFTR: Bool
    //
    func formatXAxis(xAxis: XAxis) {
        let xAxisFormatter = NumberFormatter()
        xAxisFormatter.generatesDecimalNumbers = false
        
        xAxis.valueFormatter = DefaultAxisValueFormatter(formatter: xAxisFormatter)
        
        if showCampusAverage == true {
            xAxis.labelCount = campusCount - 1
        } else if showTitleAverage == true  {
            xAxis.labelCount = titleCount - 1
        } else if showDepartmentAverage == true  {
            xAxis.labelCount = departmentCount - 1
        } else {
            xAxis.labelCount = personCount - 1
        }
        
        xAxis.labelPosition = .bottom
        //        xAxis.valueFormatter = IndexAxisValueFormatter(values: PersonLineChartOne.yearArray)
        //        xAxis.labelFont = UIFont.boldSystemFont(ofSize: 12)
        // Setting the max and min make sure that the markers are visible at the edges
        //                xAxis.axisMaximum = 3
        //                xAxis.axisMinimum = -1
        
    }
    
    func formatLeftAxis(leftAxis:YAxis) {
        let leftAxisFormatter = NumberFormatter()
        leftAxisFormatter.generatesDecimalNumbers = false
        leftAxisFormatter.numberStyle = .currency
        leftAxisFormatter.currencySymbol = "$"
        
        leftAxis.valueFormatter = DefaultAxisValueFormatter(formatter: leftAxisFormatter)
        if campusCount > 2 {
            leftAxis.labelCount = 5
        } else {
            leftAxis.labelCount = 4
        }
        
        
        
        
        //        leftAxis.labelTextColor =  .red
        //        leftAxis.labelFont = UIFont.boldSystemFont(ofSize: 12)
    }
    
    
}
