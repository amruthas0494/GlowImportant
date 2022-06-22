//
//  WelcomeViewController.swift
//  Glow
//
//  Created by Suman Reshma J on 02/06/22.
//  Copyright © 2022 CC. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {

    static let identifier = "WelcomeViewController"
    
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    
    @IBOutlet weak var continuButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        decorateUI()
    }
    func decorateUI() {
        headerLabel.setUp(title: "Hi, I'm Glow", font: UIFont.Poppins.semiBold.size(FontSize.largeTitle_24), textColor: UIColor.AppColors.darkTextColor, noOfLine: 0)
        descLabel.setUp(title: "Your Diabetes Education Companion!", font: UIFont.Poppins.medium.size(FontSize.body_17), textColor: UIColor.AppColors.grayTextColor, noOfLine: 0)
        
        
        
        continuButton.setUp(title: "Continue", font: UIFont.Poppins.medium.size(FontSize.body_17), textColor: .white, bgColor: UIColor.AppColors.themeColor, radius: Constant.viewRadius4)
       
        
    }
    
    @IBAction func continueButtonTapped(_ sender: UIButton) {
        
       let vc = IntroductionViewController.instantiateFromAppStoryBoard(appStoryBoard:  AppStoryboard.onboarding)
        self.navigationController?.pushViewController(vc, animated: true)
       
        
    }
    
}
