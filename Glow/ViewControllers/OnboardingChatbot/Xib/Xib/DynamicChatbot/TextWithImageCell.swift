//
//  TextWithImageCell.swift
//  Glow
//
//  Created by Cognitiveclouds2021_4 on 04/03/22.
//  Copyright © 2022 CC. All rights reserved.
//

import UIKit

class TextWithImageCell: UITableViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var imgVwPerson: UIImageView!
    @IBOutlet weak var vwContainer: UIView!
    @IBOutlet weak var imgVw: UIImageView!
    @IBOutlet weak var lblText: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    
    var object: StepMessage? {
        didSet {
            if let object = object {
                if let imgUrl = object.attachmentUrl {
                    let url = URL(string: imgUrl)
                    self.imgVw.kf.setImage(with: url)
                }
                lblText.text = object.text
            }
        }
    }
    
    var faqObject: BotMessage? {
        didSet {
            if let object = faqObject {
                if let imgUrl = object.attachmentUrl {
                    let url = URL(string: imgUrl)
                    self.imgVw.kf.setImage(with: url)
                }
                lblText.text = object.text
            }
        }
    }
    
    // MARK: - awakeFromNib
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        lblText.setUp(title: "", font: UIFont.Poppins.medium.size(FontSize.body_17), textColor: .AppColors.blackText, noOfLine: 0)
        lblTime.setUp(title: "", font: UIFont.Poppins.regular.size(FontSize.subtitle_11), textColor: .AppColors.grayTextColor, noOfLine: 1)
        
        self.imgVw.layer.cornerRadius = Constant.viewRadius4
        self.imgVw.clipsToBounds = true
        
        self.vwContainer.backgroundColor = .AppColors.navigationBackground
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
            
            self.imgVwPerson.layer.cornerRadius = self.imgVwPerson.frame.width/2
            self.imgVwPerson.clipsToBounds = true
        }
    }
}
