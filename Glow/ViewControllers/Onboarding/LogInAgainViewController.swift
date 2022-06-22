//
//  LogInAgainViewController.swift
//  Glow
//
//  Created by Suman Reshma J on 02/06/22.
//  Copyright © 2022 CC. All rights reserved.
//

import UIKit

class LogInAgainViewController: UIViewController {
    
    
    static let identifier = "LogInAgainViewController"
    var navController: UINavigationController! = nil
    
    @IBOutlet weak var headerLabel: UILabel!
    
    @IBOutlet weak var AlreadyRegLabel: UILabel!
    @IBOutlet weak var glowLabel: UILabel!
    @IBOutlet weak var helpLabel: UILabel!
    
    @IBOutlet weak var newHerelabel: UILabel!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var ccreateAccountButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        decorateUI()
    }
    
    func decorateUI() {
        headerLabel.setUp(title: "Let's Get To Know You", font: UIFont.Poppins.semiBold.size(FontSize.largeTitle_24), textColor: UIColor.AppColors.darkTextColor, noOfLine: 0)
        helpLabel.setUp(title: "Let me help you set your account", font: UIFont.Poppins.medium.size(FontSize.body_17), textColor: UIColor.AppColors.grayTextColor, noOfLine: 0)
        glowLabel.setUp(title: "Let's glow together!", font: UIFont.Poppins.medium.size(FontSize.body_17), textColor: UIColor.AppColors.grayTextColor, noOfLine: 0)
       // AlreadyRegLabel.setUp(title: "Already Regstered?", font: UIFont.Poppins.medium.size(FontSize.body_17), textColor: UIColor.AppColors.grayTextColor, noOfLine: 0)
        //newHerelabel.setUp(title: "New Here?", font: UIFont.Poppins.medium.size(FontSize.body_17), textColor: UIColor.AppColors.grayTextColor, noOfLine: 0)
        loginButton.setUp(title: "Already Registered?", font: UIFont.Poppins.medium.size(FontSize.body_17), textColor: .white, bgColor: UIColor.AppColors.themeColor, radius: Constant.viewRadius4)
        ccreateAccountButton.setUp(title: "Continue", font: UIFont.Poppins.medium.size(FontSize.body_17), textColor: .white, bgColor: UIColor.AppColors.themeColor, radius: Constant.viewRadius4)
        
        let stringValue = "Let's glow together!"
        
        let attribute1 = [
            NSAttributedString.Key.foregroundColor: UIColor.AppColors.grayTextColor,
            NSAttributedString.Key.font: UIFont.Poppins.medium.size(FontSize.body_17)
        ]
        let attributedText = NSMutableAttributedString(string: stringValue, attributes: attribute1)
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 4
        attributedText.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: attributedText.length))
        
        let feederRange = NSRange(location: 6, length: 4)
       
        let anotherAttribute = [NSAttributedString.Key.foregroundColor: UIColor.AppColors.themeColor]
        attributedText.addAttributes(anotherAttribute, range: feederRange)
       
      
        glowLabel.attributedText = attributedText
       
        
    }

    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        let login = AppStoryboard.onboardingChatbot.viewController(viewcontrollerClass: LoginViewController.self)
       
        self.navigationController?.pushViewController(login, animated: true)
        }
        
    
    
    
    @IBAction func createAccountTapped(_ sender: UIButton) {
       
        let account = AppStoryboard.onboardingChatbot.viewController(viewcontrollerClass: OnboardingChatbotViewController.self)
       
        self.navigationController?.pushViewController(account, animated: true)
    }
    
    
    
}
