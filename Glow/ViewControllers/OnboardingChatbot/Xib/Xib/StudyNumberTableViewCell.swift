//
//  StudyNumberTableViewCell.swift
//  Glow
//
//  Created by Cognitiveclouds on 07/06/22.
//  Copyright © 2022 CC. All rights reserved.
//

import UIKit

class StudyNumberTableViewCell: UITableViewCell {

    static let identifier = "StudyNumberTableViewCell"
    
    @IBOutlet weak var studyView: UIView!
    @IBOutlet weak var studyNumberLabel: UILabel!
    
    @IBOutlet weak var studyNumberTextField: UITextField!
    
    @IBOutlet weak var viewSubmit: UIView!
    
    @IBOutlet weak var labelSubmit: UILabel!
    
    @IBOutlet weak var submitButton: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        studyNumberLabel.setUp(title: "Study Number".Chatbotlocalized(), font: UIFont.Poppins.medium.size(FontSize.body_13), textColor: UIColor.AppColors.grayTextColor, noOfLine: 0)
        
        studyNumberTextField.backgroundColor = UIColor.AppColors.navigationBackground
        studyNumberTextField.font = UIFont.Poppins.semiBold.size(FontSize.body_15)
        studyNumberTextField.keyboardType = .default
        studyNumberTextField.isUserInteractionEnabled = true
        studyNumberTextField.becomeFirstResponder()
        
        viewSubmit.backgroundColor = UIColor.AppColors.themeColor
        viewSubmit.layer.cornerRadius = Constant.buttonRadius
        viewSubmit.clipsToBounds = true
        viewSubmit.isUserInteractionEnabled = true
        //studyView.isUserInteractionEnabled = true

        labelSubmit.setUp(title: "Submit".Chatbotlocalized(), font: UIFont.Poppins.medium.size(FontSize.body_17), textColor: .white, noOfLine: 1)
        submitButton.setUpBlank()
       // submitButton.isUserInteractionEnabled = true
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        studyNumberLabel.font = UIFont.Poppins.medium.size(FontSize.body_13)
        studyNumberTextField.font = UIFont.Poppins.semiBold.size(FontSize.body_15)
        labelSubmit.font = UIFont.Poppins.medium.size(FontSize.body_17)
        //submitButton.setUpBlank()
    }


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
