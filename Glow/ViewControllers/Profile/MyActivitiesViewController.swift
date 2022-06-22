//
//  MyActivitiesViewController.swift
//  Glow
//
//  Created by Cognitiveclouds2021_4 on 24/01/22.
//  Copyright © 2022 CC. All rights reserved.
//

import UIKit
import Charts

class MyActivitiesViewController: UIViewController, ChartViewDelegate {
    
    // MARK: - Outlets
    @IBOutlet weak var vwKnowledgeAchievement: UIView!
    @IBOutlet weak var lblKnowledgeTitle: UILabel!
    @IBOutlet weak var lblKnowledgeCount: UILabel!
    @IBOutlet weak var lblKnowledgeModule: UILabel!
    @IBOutlet weak var cvKnowledge: UICollectionView!
    @IBOutlet weak var nslcCVKnowledgeHeight: NSLayoutConstraint!
    @IBOutlet weak var vwSkillAchievement: UIView!
    @IBOutlet weak var lblSkillTitle: UILabel!
    @IBOutlet weak var lblSkillCount: UILabel!
    @IBOutlet weak var lblCoachingSession: UILabel!
    @IBOutlet weak var cvSkill: UICollectionView!
    @IBOutlet weak var nslcCVSkillHeight: NSLayoutConstraint!
    @IBOutlet weak var vwLearningJourney: UIView!
    @IBOutlet weak var lblLearningJourney: UILabel!
    @IBOutlet weak var lblDaysCount: UILabel!
    @IBOutlet weak var lblDays: UILabel!
    @IBOutlet weak var cvLearningJourney: UICollectionView!
    @IBOutlet weak var nslcCVLearningHeight: NSLayoutConstraint!
    @IBOutlet weak var vwMinuteInApp: UIView!
    @IBOutlet weak var lblMinSpendInApp: UILabel!
    @IBOutlet weak var vwGraph: UIView!
    @IBOutlet weak var lineChart: LineChartView!
    
    var entries = [ChartDataEntry]()
    let months = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat"].map({ $0.localized() })
    let unitsSold = [50.0, 25.0, 50.0, 75.0, 100.0, 75.0]
    
    // MARK: - Page life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        decorateUI()
        cvKnowledge.delegate = self
        cvKnowledge.dataSource = self
        cvSkill.delegate = self
        cvSkill.dataSource = self
        cvLearningJourney.delegate = self
        cvLearningJourney.dataSource = self
        
        
        lineChart.delegate = self
        //              for points in 0..<10 {
        //                  entries.append(ChartDataEntry(x: Double(points), y: Double(points)))
        //              }
        //              let set = LineChartDataSet(entries:entries)
        //        set.colors = ChartColorTemplates.material()
        //              let data = LineChartData(dataSet: set)
        //              lineChart.data = data
        
        setChart(dataPoints: months, values: unitsSold)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setTitle("My activities".localized(), isBackButton: true)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.nslcCVKnowledgeHeight.constant = self.cvKnowledge.collectionViewLayout.collectionViewContentSize.height
        self.cvKnowledge.setNeedsLayout()
        self.nslcCVSkillHeight.constant = self.cvSkill.collectionViewLayout.collectionViewContentSize.height
        self.cvSkill.setNeedsLayout()
        self.nslcCVLearningHeight.constant = self.cvLearningJourney.collectionViewLayout.collectionViewContentSize.height
        self.cvLearningJourney.setNeedsLayout()
    }
    
    // MARK: - Private methods
    private func decorateUI() {
        
        [vwKnowledgeAchievement, vwSkillAchievement, vwLearningJourney, vwMinuteInApp].forEach { vw in
            vw?.layer.cornerRadius = Constant.viewRadius8
            vw?.layer.borderWidth = 1
            vw?.layer.borderColor = UIColor.AppColors.borderColor_D8E1E5.cgColor
            vw?.clipsToBounds = true
        }
        
        [lblKnowledgeTitle, lblSkillTitle, lblLearningJourney, lblMinSpendInApp].forEach { lbl in
            lbl?.setUp(title: "", font: UIFont.Poppins.medium.size(FontSize.body_15), textColor: UIColor.AppColors.darkTextColor, noOfLine: 0, textAlignment: .center)
        }
        lblKnowledgeTitle.text = "Your Diabetes Knowledge achievement".localized()
        lblSkillTitle.text = "Your Diabetes Skills achievement\n(Coaching sessions completed)".localized()
        lblLearningJourney.text = "Your learning journey last week".localized()
        lblMinSpendInApp.text = "Minutes spent in the app per day".localized()
        
        [lblKnowledgeCount, lblSkillCount, lblDaysCount].forEach { lbl in
            lbl?.setUp(title: "8/16", font: UIFont.Poppins.semiBold.size(FontSize.title2_21), textColor: UIColor.AppColors.themeColor, noOfLine: 1)
        }
        [lblKnowledgeModule, lblCoachingSession, lblDays].forEach { lbl in
            lbl?.setUp(title: "", font: UIFont.Poppins.medium.size(FontSize.body_13), textColor: UIColor.AppColors.themeColor, noOfLine: 1)
        }
        lblKnowledgeModule.text = "modules".localized()
        lblCoachingSession.text = "coaching sessions".localized()
        lblDays.text = "days".localized()
    }
    
    func setChart(dataPoints: [String], values: [Double]) {
        var dataEntries: [ChartDataEntry] = []
        
        
        for i in 0..<dataPoints.count {
            let dataEntry = ChartDataEntry(x: Double(i), y: values[i], data: dataPoints[i] as AnyObject)
            dataEntries.append(dataEntry)
        }
        //color
        let red = Double(arc4random_uniform(138))
        let green = Double(arc4random_uniform(43))
        let blue = Double(arc4random_uniform(226))
        let color = UIColor(red: CGFloat(red/255), green: CGFloat(green/255), blue: CGFloat(blue/255), alpha: 1)
        
        
        let chartDataSet = LineChartDataSet(entries: dataEntries, label: nil)
        chartDataSet.circleRadius = 5
        chartDataSet.circleHoleRadius = 2
        chartDataSet.drawValuesEnabled = false
        chartDataSet.drawFilledEnabled = true
        
        //color graph
        chartDataSet.colors = [UIColor.AppColors.themeColor]
        chartDataSet.circleColors = [UIColor.AppColors.themeColor] 
        chartDataSet.circleHoleColor = UIColor.AppColors.themeColor
        //chartDataSet.isHorizontalHighlightIndicatorEnabled = false
        chartDataSet.highlightColor = UIColor.AppColors.themeColor
        
        let gradientColors = [ChartColorTemplates.colorFromString("#BA31E1").cgColor,
                              ChartColorTemplates.colorFromString("#FFFFFF").cgColor]
        let gradient = CGGradient(colorsSpace: nil, colors: gradientColors as CFArray, locations: nil)!
        
        chartDataSet.fillAlpha = 1
        chartDataSet.fill = Fill(linearGradient: gradient, angle: 270)
//        LinearGradientFill(gradient: gradient, angle: 90)
        
//        chartDataSet.fillColor = UIColor.AppColors.themeColor
        let chartData = LineChartData(dataSets: [chartDataSet])
        
        
        
        lineChart.data = chartData
        
        // lineChart.xAxis.valueFormatter = IndexAxisValueFormatter(values: months)
        lineChart.xAxis.labelPosition = .bottom
        lineChart.xAxis.valueFormatter = IndexAxisValueFormatter(values: months)
        lineChart.xAxis.setLabelCount(months.count, force: true)
        lineChart.xAxis.drawGridLinesEnabled = false
        lineChart.xAxis.avoidFirstLastClippingEnabled = true
        lineChart.gridBackgroundColor = color
        lineChart.rightAxis.drawAxisLineEnabled = false
        lineChart.rightAxis.drawLabelsEnabled = false
        
        lineChart.leftAxis.drawAxisLineEnabled = false
        lineChart.pinchZoomEnabled = false
        lineChart.doubleTapToZoomEnabled = false
        lineChart.legend.enabled = false
        let setOne = LineChartDataSet(entries: dataEntries, label: "")
        setOne.highlightColor = UIColor.AppColors.themeColor // color of the line
        setOne.highlightLineWidth = 2.0 // width of the line
        setOne.drawHorizontalHighlightIndicatorEnabled = false // hide horizontal line
        setOne.drawVerticalHighlightIndicatorEnabled = false
    }
}

// MARK: - UICollectionViewDelegateFlowLayout, UICollectionViewDataSource
extension MyActivitiesViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == cvLearningJourney {
            return 7
        }
        return 16
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == cvKnowledge || collectionView == cvSkill {
            let width = UIDevice.current.userInterfaceIdiom == .pad ? 52 : 26
            let height = UIDevice.current.userInterfaceIdiom == .pad ? 60 : 30
            return CGSize(width: width, height: height)
        } else {
            let size = UIDevice.current.userInterfaceIdiom == .pad ? 48 : 24
            return CGSize(width: size, height: size)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == cvKnowledge || collectionView == cvSkill {
            let cell = collectionView.dequeueReusableCell(withClass: TrophyCell.self, for: indexPath)
            if indexPath.item > 5 {
                cell.imgTrophy.image = UIImage(named: "blankTrophy")
            } else {
                cell.imgTrophy.image = UIImage(named: "filledTrophy")
            }
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withClass: LearningDayCell.self, for: indexPath)
            if indexPath.item > 2 {
                cell.vwContainer.backgroundColor = UIColor.AppColors.coolGrey
            } else {
                cell.vwContainer.backgroundColor = UIColor.AppColors.themeColor
            }
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        self.viewWillLayoutSubviews()
    }
}
