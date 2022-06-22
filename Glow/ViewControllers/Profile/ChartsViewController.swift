//
//  ChartsViewController.swift
//  Glow
//
//  Created by apple on 01/02/22.
//  Copyright © 2022 CC. All rights reserved.
//

import UIKit
import Charts

class ChartsViewController: UIViewController, ChartViewDelegate {
        static let identifier = "ChartsViewController"
    @IBOutlet weak var barChart: BarChartView!
    
//    let players = ["K.S. Williamson”, “S.P.D. Smith”, “V. Kohli”, “Sachin”, “J.J. Bumrah”, “R.A. Jadeja”]
//    let hundreds = [6, 8, 26, 30, 8, 10]
    var entries = [BarChartDataEntry]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        barChart.delegate = self
        for points in 0..<10 {
            entries.append(BarChartDataEntry(x: Double(points), y: Double(points)))
        }
        let set = BarChartDataSet(entries:entries)
        let data = BarChartData(dataSet: set)
        barChart.data = data
       

    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
