//
//  RflectionJCalendarViewController.swift
//  Glow
//
//  Created by apple on 21/12/21.
//  Copyright © 2021 CC. All rights reserved.
//

import UIKit
import FSCalendar

class RflectionJCalendarViewController: UIViewController {
    static let identifier = "ReflectionJournalCalenderVC"
    
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var detaillabel: UILabel!
    
    @IBOutlet weak var TopicLabel: UILabel!
    
    @IBOutlet weak var timesetLabel: UILabel!
    
    @IBOutlet weak var text1: UITextField!
    
    @IBOutlet weak var text2: UITextField!
    
    @IBOutlet weak var setTimeButton: UIButton!
    
    @IBOutlet weak var displayCalendar: FSCalendar!
    
    @IBOutlet weak var saveButton: UIButton!
    
    @IBOutlet weak var skipButton: UIButton!
    
    
    var datesArray : [String] = []
    var multipleEventsArray : [String] = []
    fileprivate let gregorian: Calendar = Calendar(identifier: .gregorian)
    fileprivate lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter
    }()
     lazy   var searchBar:UISearchBar = UISearchBar()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.displayCalendar.dataSource = self
        self.displayCalendar.delegate = self
        _ = DateFormatter()
        datesArray = ["12/04/2019", "23/02/2021", "04/08/2021", "18/03/2021", "22/08/2021", "02/11/2021", "12/12/2021"]
        multipleEventsArray = ["23/02/2021", "04/08/2021", "18/03/2021","22/08/2021"]
        // Do any additional setup after loading the view.
        
        decorateUI()
       // dropShadow()
      

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    // MARK: - UI Setup
    
    private func decorateUI() {
        
        self.titleLabel.setUp(title: "Digital Coaching Session".localized(), font: UIFont.Poppins.medium.size(FontSize.body_17), textColor: UIColor.AppColors.themeColor, noOfLine: 0)
        
        self.detaillabel.setUp(title: "Glow digital companion will help you review what you have just learned, set a reminder for a coaching session".localized(), font: UIFont.Poppins.regular.size(FontSize.body_13), textColor: UIColor.AppColors.darkTextColor, noOfLine: 0)
        self.TopicLabel.setUp(title: "Topic: Cutting Nails".localized(), font: UIFont.Poppins.medium.size(FontSize.body_15), textColor: UIColor.AppColors.themeColor, noOfLine: 0)
        self.timesetLabel.setUp(title: "Set a Time".localized(), font: UIFont.Poppins.medium.size(FontSize.subtitle_12), textColor: UIColor.AppColors.blackText, noOfLine: 0)
        
        [text1, text2].forEach { lbl in
            lbl?.font = UIFont.Poppins.medium.size(FontSize.subtitle_11)
            lbl?.textColor = UIColor.AppColors.blackText
            lbl?.layer.cornerRadius = Constant.viewRadius4
            lbl?.layer.borderWidth = Constant.viewBorder
            lbl?.layer.borderColor = UIColor.AppColors.borderColor.cgColor
            lbl?.clipsToBounds = true
            lbl?.placeholder = "00"
        }
        self.text2.text = ""
        self.text2.text = ""
        displayCalendar.layer.cornerRadius = Constant.viewRadius12
        displayCalendar.layer.shadowColor = UIColor.gray.cgColor
        displayCalendar.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        displayCalendar.layer.shadowOpacity = 0.5
        displayCalendar.layer.shadowRadius = 4.0
        setTimeButton.setUp(title: "Set".localized(), font: UIFont.Poppins.bold.size(FontSize.subtitle_12), textColor: UIColor.AppColors.whiteTextColor, bgColor: UIColor.AppColors.themeColor, radius: Constant.viewRadius4)
        saveButton.setUp(title: "Save".localized(), font: UIFont.Poppins.medium.size(FontSize.body_17), textColor: UIColor.AppColors.whiteTextColor, bgColor: UIColor.AppColors.themeColor, radius: 4)
        
        
        skipButton.setUp(title: "Skip".localized(), font: UIFont.Poppins.medium.size(FontSize.body_17), textColor: UIColor.AppColors.themeColor, bgColor: UIColor.white, radius: 4)
        
        
        
        
    }
   
    
    @IBAction func BackbuttonTapped(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func searchTapped(_ sender: UIBarButtonItem) {
        let leftNavBarButton = UIBarButtonItem(customView:searchBar)
              self.navigationItem.leftBarButtonItem = leftNavBarButton
    }
    
    @IBAction func setTimebtnTapped(_ sender: UIButton) {
        
    }
    
    
    @IBAction func saveTapped(_ sender: UIButton) {
        
        
    }
    
    @IBAction func settingTapped(_ sender: UIBarButtonItem) {
    }
    
    @IBAction func skipbtnTapped(_ sender: UIButton) {
        
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
extension RflectionJCalendarViewController : FSCalendarDataSource {
    
    //    //Set Minimum Date
    //    func minimumDate(for calendar: FSCalendar) -> Date {
    //        return dateFormatter.date(from: "01/01/2000") ?? Date()
    //    }
    //
    //    //Set maximum Date
    //    func maximumDate(for calendar: FSCalendar) -> Date {
    ////          let dateFormatter = DateFormatter()
    ////          dateFormatter.dateFormat = "dd-mm-yyyy"
    //        return dateFormatter.date(from: "27/10/2032") ?? Date()
    //    }
    
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        
        // dateFormatter.locale = Locale.init(identifier: "fa_IR")
        let dateString = self.dateFormatter.string(from: date)
        
                   if self.datesArray.contains(dateString) {
                       return 1
                   }
                   if self.multipleEventsArray.contains(dateString) {
                    return multipleEventsArray.count
                   }
        return 0
        
    }
    
    
    
}

extension RflectionJCalendarViewController : FSCalendarDelegate {
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print("did select date \(self.dateFormatter.string(from: date))")
        let selectedDates = calendar.selectedDates.map({self.dateFormatter.string(from: $0)})
        print("selected dates is \(selectedDates)")
        if monthPosition == .next || monthPosition == .previous {
            calendar.setCurrentPage(date, animated: true)
        }
    }
    
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        print("\(self.dateFormatter.string(from: calendar.currentPage))")
    }
    
}
extension RflectionJCalendarViewController : FSCalendarDelegateAppearance {
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, eventDefaultColorsFor date: Date) -> [UIColor]? {
        let key = self.dateFormatter.string(from: date)
        if self.multipleEventsArray.contains(key) {
            return [UIColor.cyan, appearance.eventSelectionColor, UIColor.black]
        }
        
        return nil
    }
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, eventSelectionColorsFor date: Date) -> [UIColor]? {
        let key1 = self.dateFormatter.string(from: date)
        if self.datesArray.contains(key1) {
            return [UIColor.red, appearance.eventSelectionColor, UIColor.black]
        }
        return nil
    }
}

