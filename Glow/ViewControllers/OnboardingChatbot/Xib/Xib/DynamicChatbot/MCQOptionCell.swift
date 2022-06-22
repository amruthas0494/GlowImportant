//
//  MCQOptionCell.swift
//  Glow
//
//  Created by Cognitiveclouds2021_4 on 10/03/22.
//  Copyright © 2022 CC. All rights reserved.
//

import UIKit

class MCQOptionCell: UITableViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var vwContainer: UIView!
    @IBOutlet weak var imgVw: UIImageView!
    @IBOutlet weak var nslcImageHeight: NSLayoutConstraint!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var btnOption: UIButton!
    
    var objOption: StepOption? {
        didSet {
            if let objOption = objOption {
                if let imgUrl = objOption.imageUrl {
                    let url = URL(string: imgUrl)
                    self.imgVw.kf.setImage(with: url)
                    imgVw.isHidden = false
                    nslcImageHeight.constant = UIDevice.current.userInterfaceIdiom == .phone ? 60 : 120
                } else {
                    imgVw.isHidden = true
                }
            lblTitle.text = objOption.text
               // lblTitle.setText(value: objOption.text, highlight: searchedText)
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        decorateUI()
    }
    
    private func decorateUI() {
        
        self.vwContainer.layer.cornerRadius = Constant.viewRadius4
        self.vwContainer.backgroundColor = .AppColors.themeColor
        self.vwContainer.clipsToBounds = true
        
        self.imgVw.layer.cornerRadius = Constant.viewRadius4
        self.imgVw.clipsToBounds = true
        
        self.lblTitle.setUp(title: "", font: UIFont.Poppins.medium.size(FontSize.body_15), textColor: .white, noOfLine: 0)
    }
}
