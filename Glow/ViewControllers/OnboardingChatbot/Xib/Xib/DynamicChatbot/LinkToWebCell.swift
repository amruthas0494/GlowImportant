//
//  LinkToWebCell.swift
//  Glow
//
//  Created by Cognitiveclouds on 21/06/22.
//  Copyright © 2022 CC. All rights reserved.
//

import UIKit



class LinkToWebCell: UITableViewCell {
    
    static let identifier = "LinkToWebCell"
    
    // MARK: - Outlets
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var vwContainer: UIView!
    @IBOutlet weak var lblText: UILabel!
  
    @IBOutlet weak var labeltext: UnderlinedLabel!
    @IBOutlet weak var lblTime: UILabel!
    
   
    var objStepResponseMsglink: StepMessage? {
        didSet {
            if let objStepResponseMsg = objStepResponseMsglink {
                lblText.text = objStepResponseMsg.attachmentUrl
                if let value = lblText.text {
                    // Create a new Attributed String
                    let attributedString = NSMutableAttributedString.init(string:value)
                            
                            // Add Underline Style Attribute.
                            attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: 1, range:
                                NSRange.init(location: 0, length: attributedString.length));
                    lblText.attributedText = attributedString
                }
              
                let tap = UITapGestureRecognizer(target: self, action: #selector(onLabelLinkTapped))
                lblText.isUserInteractionEnabled = true
                lblText.addGestureRecognizer(tap)
                vwContainer.isUserInteractionEnabled = true
                let tap1 = UITapGestureRecognizer(target: self, action: #selector(onLabelLinkTapped))
               
                vwContainer.addGestureRecognizer(tap)
            }
        }
    }
    var delegate: TextViewDelegate?

    
    // MARK: - awakeFromNib
    override func awakeFromNib() {
        super.awakeFromNib()
        

        lblText.setUp(title: "", font: UIFont.Poppins.medium.size(FontSize.body_17), textColor: UIColor.AppColors.linkColor, noOfLine: 0)
      
        
//        lblText.font = UIFont.preferredCustomFont(forTextStyle: UIFont.TextStyle.headline)
        lblTime.setUp(title: "", font: UIFont.Poppins.regular.size(FontSize.subtitle_11), textColor: UIColor.AppColors.grayTextColor, noOfLine: 1)

        lblText.setUp(title: "", font: UIFont.Poppins.medium.size(FontSize.body_17), textColor: UIColor.AppColors.linkColor, noOfLine: 0)
        lblText.isUserInteractionEnabled = true
        lblTime.setUp(title: "", font: UIFont.Poppins.regular.size(FontSize.subtitle_11), textColor: UIColor.AppColors.grayTextColor, noOfLine: 1)
       

        
        self.vwContainer.backgroundColor = UIColor.AppColors.navigationBackground
        self.vwContainer.layer.borderWidth = Constant.viewBorder3
        self.vwContainer.layer.borderColor = UIColor.AppColors.border_Color.cgColor
        vwContainer.isUserInteractionEnabled = true
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
            
            self.imgView.layer.cornerRadius = self.imgView.frame.width/2
            self.imgView.clipsToBounds = true
        }
    }
    
    func changeFontSize(size: CGFloat) {
        self.lblText.font = UIFont.Poppins.medium.size(size)
    }
    
    
    @objc func onLabelLinkTapped() {
        if let webLink = objStepResponseMsglink?.attachmentUrl {
            self.delegate?.moveToWebPage(link:webLink)
        }
        
    }
}

