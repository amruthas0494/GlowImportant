//
//  EducationCollectionViewCell.swift
//  Glow
//
//  Created by Nidhishree HP on 21/12/21.
//  Copyright © 2021 CC. All rights reserved.
//

import UIKit

class EducationCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var background:UIView!
    @IBOutlet weak var favouriteButton: UIButton!
    @IBOutlet weak var imgFavourite: UIImageView!
    @IBOutlet weak var separatorView: UIView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var unitsLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var recommendedImage: UIImageView!
    @IBOutlet weak var progress: UIProgressView!
    @IBOutlet weak var imgCompletion: UIImageView!
    
    // MARK: - Variables
    var onClickBookmarks:(() -> ())?
    var onClickFavourite:(() -> ())?
    var lesson: EducationLesson? {
        didSet {
            titleLabel.text = lesson?.name
            if let imgUrl = lesson?.imageUrl, let encodedUrl = imgUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
                let url = URL(string: encodedUrl)
                recommendedImage.kf.setImage(with: url)
            } else {
                recommendedImage.image = UIImage(named: "noImage")
            }
            imgFavourite.image = (lesson?.favourites ?? []).isEmpty ? UIImage(named: "favourite") : UIImage(named: "unfavourite")
            if let unitCount = lesson?.pageCount {
                unitsLabel.text = "\(unitCount) units"
            }
            progress.progress = Float(lesson?.participantCompletedUnit ?? 0)/Float(lesson?.pageCount ?? 0)
            imgCompletion.isHidden = Int(lesson?.participantCompletedUnit ?? 0) != Int(lesson?.pageCount ?? 0)
        }
    }
    
    // MARK: - awakeFromNib
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    func setupUI() {
        
        background.backgroundColor = UIColor.AppColors.navigationBackground
        background.layer.borderWidth = Constant.viewBorder1
        background.layer.borderColor = UIColor.AppColors.cellBorder.cgColor
        background.layer.cornerRadius = Constant.viewRadius8
        background.clipsToBounds = true
        
        titleLabel.setUp(title: "", font: UIFont.Poppins.semiBold.size(FontSize.body_15), textColor: UIColor.AppColors.darkTextColor, noOfLine: 0)
        unitsLabel.setUp(title: "", font: UIFont.Poppins.medium.size(FontSize.subtitle_11), textColor: UIColor.AppColors.grayTextColor, noOfLine: 1)
        timeLabel.setUp(title: "", font: UIFont.Poppins.medium.size(FontSize.subtitle_11), textColor: UIColor.AppColors.grayTextColor, noOfLine: 1)
        progress.progressTintColor = UIColor.AppColors.themeColor
    }

    @IBAction func bookmarksTapped(_ sender: Any) {
        onClickBookmarks?()
    }
    @IBAction func favouriteTapped(_ sender: Any) {
        onClickFavourite?()
    }
}
