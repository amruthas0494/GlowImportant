//
//  LeftTextViewCell.swift
//  Glow
//
//  Created by Pushpa Yadav on 22/11/21.
//  Copyright © 2021 CC. All rights reserved.
//

import UIKit

protocol TextViewDelegate: AnyObject {
    func moveToEducationLesson(educationLesson: BotEducationLesson)
    func moveToUnit(lesson: BotEducationLesson, unit: Unit)
    func moveToUnitPage(lesson: BotEducationLesson, unit: Unit, page: EducationLessonPage)
    func moveToWebPage(link:String)
}

class LeftTextViewCell: UITableViewCell {
    
    static let identifier = "LeftTextViewCell"
    
    // MARK: - Outlets
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var vwContainer: UIView!
    @IBOutlet weak var lblText: UILabel!
  
    @IBOutlet weak var lblTime: UILabel!
    
    var objStepResponseMsg: StepResponseMessages? {
        didSet {
            if let objStepResponseMsg = objStepResponseMsg {
                lblText.text = objStepResponseMsg.text
                let tap = UITapGestureRecognizer(target: self, action: #selector(onLblTitleTap))
                lblText.isUserInteractionEnabled = true
                lblText.addGestureRecognizer(tap)
            }
        }
    }
    var objStepResponseMsglink: StepMessage? {
        didSet {
            if let objStepResponseMsg = objStepResponseMsglink {
                lblText.text = objStepResponseMsg.attachmentUrl
                let tap = UITapGestureRecognizer(target: self, action: #selector(onLabelLinkTapped))
                lblText.isUserInteractionEnabled = true
                lblText.addGestureRecognizer(tap)
            }
        }
    }
    var delegate: TextViewDelegate?
    var step:String?
    
    // MARK: - awakeFromNib
    override func awakeFromNib() {
        super.awakeFromNib()
        

        lblText.setUp(title: "", font: UIFont.Poppins.medium.size(FontSize.body_17), textColor: UIColor.AppColors.blackText, noOfLine: 0)
//        lblText.font = UIFont.preferredCustomFont(forTextStyle: UIFont.TextStyle.headline)
        lblTime.setUp(title: "", font: UIFont.Poppins.regular.size(FontSize.subtitle_11), textColor: UIColor.AppColors.grayTextColor, noOfLine: 1)

        lblText.setUp(title: "", font: UIFont.Poppins.medium.size(FontSize.body_17), textColor: UIColor.AppColors.blackText, noOfLine: 0)
        lblTime.setUp(title: "", font: UIFont.Poppins.regular.size(FontSize.subtitle_11), textColor: UIColor.AppColors.grayTextColor, noOfLine: 1)
        

        
//        self.imgView.layer.cornerRadius = self.imgView.frame.width/2
//        self.imgView.clipsToBounds = true
        
        self.vwContainer.backgroundColor = UIColor.AppColors.navigationBackground
        self.vwContainer.layer.borderWidth = Constant.viewRadius4
        self.vwContainer.layer.borderColor = UIColor.AppColors.border_Color.cgColor
       
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        lblText.font = UIFont.Poppins.medium.size(FontSize.body_17)
        lblTime.font = UIFont.Poppins.regular.size(FontSize.subtitle_11)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        DispatchQueue.main.async {
            let path = UIBezierPath(roundedRect: self.vwContainer.bounds, byRoundingCorners: [.topRight, .bottomLeft, .bottomRight], cornerRadii: CGSize(width: Constant.viewRadius16, height: Constant.viewRadius16))
            let mask = CAShapeLayer()
            mask.path = path.cgPath
            self.vwContainer.layer.mask = mask
            self.vwContainer.clipsToBounds = true
            self.imgView.layer.cornerRadius = self.imgView.frame.width/2
            self.imgView.clipsToBounds = true
        }
    }
    
    func changeFontSize(size: CGFloat) {
        self.lblText.font = UIFont.Poppins.medium.size(size)
    }
    
    @objc func onLblTitleTap() {
        if let _ = objStepResponseMsg?.educationLessonId,
            let _ = objStepResponseMsg?.educationLessonUnitId,
            let _ = objStepResponseMsg?.educationLessonPageId,
            let lesson = objStepResponseMsg?.educationLesson,
            let unit = objStepResponseMsg?.educationLessonUnit,
            let page = objStepResponseMsg?.educationLessonPage {
            self.delegate?.moveToUnitPage(lesson: lesson, unit: unit, page: page)
        } else if let _ = objStepResponseMsg?.educationLessonId,
                  let _ = objStepResponseMsg?.educationLessonUnitId,
                  let lesson = objStepResponseMsg?.educationLesson,
                  let unit = objStepResponseMsg?.educationLessonUnit {
            self.delegate?.moveToUnit(lesson: lesson, unit: unit)
        } else if let _ = objStepResponseMsg?.educationLessonId,
                  let lesson = objStepResponseMsg?.educationLesson {
            self.delegate?.moveToEducationLesson(educationLesson: lesson)
        }
    }
    @objc func onLabelLinkTapped() {
        if let webLink = objStepResponseMsglink?.attachmentUrl {
            self.delegate?.moveToWebPage(link:webLink)
        }
        
    }
}
