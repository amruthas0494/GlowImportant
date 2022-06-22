//
//  DatePickerCell.swift
//  Glow
//
//  Created by Pushpa Yadav on 01/12/21.
//  Copyright © 2021 CC. All rights reserved.
//

import UIKit

class DatePickerCell: UITableViewCell {
    
    static let identifier = "DatePickerCell"
    
    // MARK: - Outlet
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var vwSubmit: UIView!
    @IBOutlet weak var lblSubmit: UILabel!
    @IBOutlet weak var btnSubmit: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        
//        datePicker.maximumDate = Date()
        vwSubmit.backgroundColor = UIColor.AppColors.themeColor
        vwSubmit.layer.cornerRadius = Constant.buttonRadius
        vwSubmit.clipsToBounds = true
        
        lblSubmit.setUp(title: "Submit".Chatbotlocalized(), font: UIFont.Poppins.medium.size(FontSize.body_17), textColor: .white, noOfLine: 1)
        btnSubmit.setUpBlank()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        lblSubmit.font = UIFont.Poppins.medium.size(FontSize.body_17)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
