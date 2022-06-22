//
//  MCQTextCell.swift
//  Glow
//
//  Created by Cognitiveclouds2021_4 on 04/03/22.
//  Copyright © 2022 CC. All rights reserved.
//

import UIKit

class MCQTextCell: UICollectionViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var vwContainer: UIView!
    @IBOutlet weak var imgVwOption: UIImageView!
    @IBOutlet weak var lblOption: UILabel!
    @IBOutlet weak var nslcImgHeight: NSLayoutConstraint!
    
    var objOption: StepOption? {
        didSet {
            if let objOption = objOption {
                if let imgUrl = objOption.imageUrl {
                    let url = URL(string: imgUrl)
                    self.imgVwOption.kf.setImage(with: url)
                    imgVwOption.isHidden = false
                    nslcImgHeight.constant = Constant.buttonHeight
                } else {
                    imgVwOption.isHidden = true
                }
                lblOption.text = objOption.text
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        decorateUI()
    }
    
    private func decorateUI() {
        
        self.vwContainer.layer.cornerRadius = Constant.viewRadius4
        self.vwContainer.backgroundColor = .AppColors.themeColor
        self.vwContainer.clipsToBounds = true
        
        self.imgVwOption.layer.cornerRadius = Constant.viewRadius23
        self.imgVwOption.clipsToBounds = true
        
        self.lblOption.setUp(title: "", font: UIFont.Poppins.medium.size(FontSize.body_15), textColor: .white, noOfLine: 0)
        
    }
}
