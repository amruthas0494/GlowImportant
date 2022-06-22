//
//  ReccommededCell.swift
//  Glow
//
//  Created by Cognitiveclouds2021_4 on 11/01/22.
//  Copyright © 2022 CC. All rights reserved.
//

import UIKit

class ReccommededCell: UITableViewCell {
    
    static let identifier = "ReccommededCell"
    
    // MARK: - Outlets
    @IBOutlet weak var vwBackground: UIView!
    @IBOutlet weak var imgVwLesson: UIImageView!
    @IBOutlet weak var imgCompleted: UIImageView!
    @IBOutlet weak var progressLesson: UIProgressView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblUnits: UILabel!
    @IBOutlet weak var lblTotalHours: UILabel!
    @IBOutlet weak var imgFavourite: UIImageView!
    @IBOutlet weak var btnFavourite: UIButton!
    
    var objLesson: EducationLesson? {
        didSet {
            if let imgUrl = objLesson?.imageUrl, let encodedUrl = imgUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
                let url = URL(string: encodedUrl)
                imgVwLesson.kf.setImage(with: url)
            } else {
                imgVwLesson.image = UIImage(named: "noImage")
            }
            imgCompleted.isHidden = Int(objLesson?.participantCompletedUnit ?? 0) != Int(objLesson?.pageCount ?? 0)
            progressLesson.progress = Float(objLesson?.participantCompletedUnit ?? 0)/Float(objLesson?.pageCount ?? 0)
            lblTitle.text = objLesson?.name
            if let unitCount = objLesson?.pageCount {
                lblUnits.text = "\(unitCount) units".localized()
            }
            imgFavourite.image = (objLesson?.favourites ?? []).isEmpty ?
            UIImage(named: "favourite") : UIImage(named: "unfavourite")
        }
    }
    
    var objFavouriteModule: FavouriteModule? {
        didSet {
            if let imgUrl = objFavouriteModule?.educationLesson?.imageUrl, let encodedUrl = imgUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
                let url = URL(string: encodedUrl)
                imgVwLesson.kf.setImage(with: url)
            } else {
                imgVwLesson.image = UIImage(named: "noImage")
            }
            imgCompleted.isHidden = true
            progressLesson.isHidden = true
            lblTitle.text = objFavouriteModule?.educationLesson?.name
            if let unitCount = objFavouriteModule?.educationLesson?.pageCount {
                lblUnits.text = "\(unitCount) units"
            }
            imgFavourite.image = UIImage(named: "unfavourite")
        }
    }

    // MARK: - awakeFromNib
    override func awakeFromNib() {
        super.awakeFromNib()
        decorateUI()
    }
    
    private func decorateUI() {
        
        vwBackground.backgroundColor = UIColor.AppColors.navigationBackground
        vwBackground.layer.borderWidth = Constant.viewBorder1
        vwBackground.layer.borderColor = UIColor.AppColors.cellBorder.cgColor
        vwBackground.layer.cornerRadius = Constant.viewRadius8
        vwBackground.clipsToBounds = true
        
        lblTitle.setUp(title: "", font: UIFont.Poppins.semiBold.size(FontSize.body_15), textColor: UIColor.AppColors.darkTextColor, noOfLine: 0)
        lblUnits.setUp(title: "", font: UIFont.Poppins.medium.size(FontSize.subtitle_11), textColor: UIColor.AppColors.grayTextColor, noOfLine: 1)
        lblTotalHours.setUp(title: "", font: UIFont.Poppins.medium.size(FontSize.subtitle_11), textColor: UIColor.AppColors.grayTextColor, noOfLine: 1)
        btnFavourite.setUpBlank()
        
        progressLesson.progressTintColor = UIColor.AppColors.themeColor
        progressLesson.trackTintColor = UIColor.AppColors.FCECFF
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
