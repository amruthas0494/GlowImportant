//
//  QuizTableViewCell.swift
//  Glow
//
//  Created by Nidhishree HP on 21/12/21.
//  Copyright © 2021 CC. All rights reserved.
//

import UIKit

class QuizTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var startQuizButton: UIButton!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var quizImage: UIImageView!
    @IBOutlet weak var separator: UIView!
    
    var objectBot: Bot? {
        didSet {
            if let objectBot = objectBot {
                titleLabel.text = objectBot.name
            }
        }
    }
    
    // MARK: - awakeFromNib
    override func awakeFromNib() {
        super.awakeFromNib()
        
        decorateUI()
    }
    
    private func decorateUI() {
        
        quizImage.layer.cornerRadius = Constant.viewRadius8
        quizImage.clipsToBounds = true
        
        titleLabel.setUp(title: "Care for your Feet".Chatbotlocalized(), font: UIFont.Poppins.semiBold.size(FontSize.body_15), textColor: UIColor.AppColors.darkTextColor, noOfLine: 1)
        questionLabel.setUp(title: "12 questions".Chatbotlocalized(), font: UIFont.Poppins.medium.size(FontSize.subtitle_11), textColor: UIColor.AppColors.grayTextColor, noOfLine: 1)
        startQuizButton.setUp(title: "Start Quiz".Chatbotlocalized(), font: UIFont.Poppins.medium.size(FontSize.body_13), textColor: .white, bgColor: UIColor.AppColors.themeColor, radius: Constant.viewRadius4)
        
        separator.backgroundColor = UIColor.AppColors.sepratorColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
