//
//  PersonLineChartOne.swift
//  UMICHSalaryPub (iOS)
//
//  Created by David Malicke on 3/14/21.
//

import Charts
import SwiftUI

///This is the struct the creates the line charts used in the PersonInsightView.
///All of the following funcs are used to format and populate the line chart.
struct PersonLineChartView: UIViewRepresentable {
    @StateObject private var vm = PersonInsightViewModel()
    
    @Binding var showTitleAverage: Bool
    @Binding var showDepartmentAverage: Bool
    @Binding var showCampusAverage: Bool
    @Binding var showAnnualFTR: Bool
    
    let lineChart = LineChartView()
    let person: PersonViewModel
    let year: Int64
    
    func makeUIView(context: Context) -> LineChartView {
        vm.getPersons(vm: person)
        vm.getTitles(vm: person, year: year)
        vm.getDepartments(vm: person, year: year)
        vm.getCampuses(vm: person, year: year)
        vm.getChartData()
        
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
        let personSetAnnualFTR = LineChartDataSet(entries: vm.personEntryAnnualFTR)
        let personSetTitleAverageAnnual = LineChartDataSet(entries: vm.personEntryTitleAverageAnnual)
        let personSetDepartmentAverageAnnual = LineChartDataSet(entries: vm.personEntryDepartmentAverageAnnual)
        let personSetCampusAverageAnnual = LineChartDataSet(entries: vm.personEntryCampusAverageAnnual)

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
    
            if showTitleAverage == false, showDepartmentAverage == false, showCampusAverage == false, showAnnualFTR == false {
                dataSets.append(personSetAnnualFTR)
            }
            
            return dataSets
        }
        
        let lineChartData = LineChartData(dataSets: createDataSets(
            showTitleAverage: showTitleAverage,
            showDepartmentAverage: showDepartmentAverage,
            showCampusAverage: showCampusAverage,
            showAnnualFTR: showAnnualFTR))
        
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
    }

    func formatXAxis(xAxis: XAxis) {
        let xAxisFormatter = NumberFormatter()
        xAxisFormatter.generatesDecimalNumbers = false
        xAxis.valueFormatter = DefaultAxisValueFormatter(formatter: xAxisFormatter)
        
        if vm.showCampusAverage == true {
            xAxis.labelCount = vm.campusCount - 1
        } else if vm.showTitleAverage == true {
            xAxis.labelCount = vm.titleCount - 1
        } else if vm.showDepartmentAverage == true {
            xAxis.labelCount = vm.departmentCount - 1
        } else {
            xAxis.labelCount = vm.personCount - 1
        }
        
        xAxis.labelPosition = .bottom
    }

    func formatLeftAxis(leftAxis: YAxis) {
        let leftAxisFormatter = NumberFormatter()
        leftAxisFormatter.generatesDecimalNumbers = false
        leftAxisFormatter.numberStyle = .currency
        leftAxisFormatter.currencySymbol = "$"
        leftAxis.valueFormatter = DefaultAxisValueFormatter(formatter: leftAxisFormatter)
        if vm.campusCount > 2 {
            leftAxis.labelCount = 5
        } else {
            leftAxis.labelCount = 4
        }
    }
}
