//
//  ReadingFontSizeCell.swift
//  Glow
//
//  Created by Pushpa Yadav on 20/12/21.
//  Copyright © 2021 CC. All rights reserved.
//

import UIKit

class ReadingFontSizeCell: UITableViewCell {
    
    static let identifier = "ReadingFontSizeCell"
    
    // MARK: - Outlet
    @IBOutlet weak var vwFont14: UIView!
    @IBOutlet weak var lblFont14: UILabel!
    @IBOutlet weak var btnFont14: UIButton!
    @IBOutlet weak var vwFont16: UIView!
    @IBOutlet weak var lblFont16: UILabel!
    @IBOutlet weak var btnFont16: UIButton!
    @IBOutlet weak var vwFont18: UIView!
    @IBOutlet weak var lblFont18: UILabel!
    @IBOutlet weak var btnFont18: UIButton!
    @IBOutlet weak var vwFont20: UIView!
    @IBOutlet weak var lblFont20: UILabel!
    @IBOutlet weak var btnFont20: UIButton!
    
    let iPhoneFonts: [(CGFloat, String)] = [(14, "14 - Hello David"), (16, "16 - Hello David"), (18, "18 - Hello David"), (20, "20 - Hello David")]
    let iPadFonts: [(CGFloat, String)] = [(28, "28 - Hello David"), (30, "30 - Hello David"), (32, "32 - Hello David"), (34, "34 - Hello David")]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        [vwFont14, vwFont16, vwFont18, vwFont20].forEach { vw in
            vw?.backgroundColor = UIColor.AppColors.themeColor
            vw?.layer.cornerRadius = Constant.buttonRadius
            vw?.clipsToBounds = true
        }
        lblFont14.setUp(title: "14 - Hello David".Chatbotlocalized(), font: UIFont.Poppins.medium.size(14), textColor: UIColor.white, noOfLine: 1)
        lblFont16.setUp(title: "16 - Hello David".Chatbotlocalized(), font: UIFont.Poppins.medium.size(16), textColor: UIColor.white, noOfLine: 1)
        lblFont18.setUp(title: "18 - Hello David".Chatbotlocalized(), font: UIFont.Poppins.medium.size(18), textColor: UIColor.white, noOfLine: 1)
        lblFont20.setUp(title: "20 - Hello David".Chatbotlocalized(), font: UIFont.Poppins.medium.size(20), textColor: UIColor.white, noOfLine: 1)
        [btnFont14, btnFont16, btnFont18, btnFont20].forEach { btn in
            btn?.setUpBlank()
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
