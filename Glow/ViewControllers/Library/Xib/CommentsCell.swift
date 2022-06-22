//
//  CommentsCell.swift
//  Glow
//
//  Created by Pushpa Yadav on 22/12/21.
//  Copyright © 2021 CC. All rights reserved.
//

import UIKit

class CommentsCell: UITableViewCell {
    
    static let identifier = "CommentsCell"
    
    // MARK: - Outlets
    @IBOutlet weak var imgUser: UIImageView!
    @IBOutlet weak var lblUser: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblComment: UILabel!
    
    // MARK: - Variables
    var objComment: Comment? {
        didSet {
            if let object = objComment {
                if let commenter = object.commenter {
                    if let imgUrl = commenter.profileImage {
                        let url = URL(string: imgUrl)
                        imgUser.kf.setImage(with: url)
                    }
                    lblUser.text = "\(commenter.firstName ?? "") \(commenter.lastName ?? "")"
                }
                if let createdAt = object.createdAt, let dtCreatedAt = createdAt.toDate() {
                    lblTime.text = dtCreatedAt.timeAgoSinceDate()
                } else {
                    lblTime.text = object.createdAt
                }
                lblComment.text = object.comment ?? ""
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        lblUser.setUp(title: "", font: UIFont.Poppins.medium.size(FontSize.body_15), textColor: UIColor.AppColors.darkTextColor, noOfLine: 1)
        lblTime.setUp(title: "", font: UIFont.Poppins.regular.size(FontSize.subtitle_11), textColor: UIColor.AppColors.grayTextColor, noOfLine: 1)
        lblComment.setUp(title: "", font: UIFont.Poppins.regular.size(FontSize.body_15), textColor: UIColor.AppColors.grayTextColor, noOfLine: 0)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imgUser.layer.cornerRadius = UIDevice.current.userInterfaceIdiom == .pad ? 50 : 25
        imgUser.clipsToBounds = true
    }
    
}
