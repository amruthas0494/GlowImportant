//
//  QuestionTableViewCell.swift
//  Glow
//
//  Created by Nidhishree HP on 08/12/21.
//  Copyright © 2021 CC. All rights reserved.
//

import UIKit

protocol QuestionTableDelegate: AnyObject {
    func onImgProfileTap()
}

class QuestionTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var headingLabel: UILabel!
    @IBOutlet weak var askQuestionLabel: UILabel!
    @IBOutlet weak var unblockLabel: UILabel!
    @IBOutlet weak var glowView: UIView!
    weak var delegate: QuestionTableDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(onImgProfileTap(gesture:)))
        imgProfile.isUserInteractionEnabled = true
        imgProfile.addGestureRecognizer(tapGesture)
        setupUI()
        
        if let imgUrl = Glow.sharedInstance.imageProfile {
            let url = URL(string: imgUrl)
            self.imgProfile.kf.setImage(with: url)
        }
        self.headingLabel.text = "Hi \(Glow.sharedInstance.firstName ?? "")"
    }
    
    func setupUI() {
        headingLabel.font = UIFont.Poppins.semiBold.size(FontSize.headline_19)
        subtitleLabel.font = UIFont.Poppins.regular.size(FontSize.body_15)
        askQuestionLabel.font = UIFont.Poppins.semiBold.size(FontSize.headline_19)
        unblockLabel.font = UIFont.Poppins.medium.size(FontSize.subtitle_11)
        
        imgProfile.layer.cornerRadius = Constant.viewRadius8
        self.imgProfile.layer.borderWidth = Constant.viewRadius4
        self.imgProfile.layer.borderColor = UIColor.AppColors.borderColor.cgColor
        glowView.layer.cornerRadius = Constant.viewRadius8
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    @objc func onImgProfileTap(gesture: UIGestureRecognizer) {
        self.delegate?.onImgProfileTap()
    }
    
}
