//
//  ForgotPasswordViewController.swift
//  Glow
//
//  Created by Cognitiveclouds2021_4 on 23/02/22.
//  Copyright © 2022 CC. All rights reserved.
//

import UIKit
import ProgressHUD

class ForgotPasswordViewController: UIViewController {
    
    static let identifier = "ForgotPasswordViewController"
    
    // MARK: - Outlets
    @IBOutlet weak var lblForgotPass: UILabel!
    @IBOutlet weak var lblSubTitle: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var lblRememberPass: UILabel!
    @IBOutlet weak var btnSendResetLink: UIButton!
    @IBOutlet weak var btnLogin: UIButton!
    
    // MARK: - Variables
    let loginViewModel = LoginViewModel()
    let onboardingViewModel = OnboardingChatbotViewModel()

    // MARK: - Page life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        decorateUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    // MARK: - Private methods
    private func decorateUI() {
        
        lblForgotPass.setUp(title: "Forgot Password".Chatbotlocalized(), font: UIFont.Poppins.semiBold.size(FontSize.title1_23), textColor: .AppColors.themeColor, noOfLine: 1)
        lblSubTitle.setUp(title: "Enter the email and a reset password link will sent to registered mail".Chatbotlocalized(), font: UIFont.Poppins.medium.size(FontSize.body_13), textColor: .darkText, noOfLine: 0)
        lblEmail.setUp(title: "Email".Chatbotlocalized(), font: UIFont.Poppins.medium.size(FontSize.body_13), textColor: .AppColors.darkTextColor, noOfLine: 1)
        lblRememberPass.setUp(title: "Remember password?".Chatbotlocalized(), font: UIFont.Poppins.regular.size(FontSize.body_13), textColor: .AppColors.darkTextColor, noOfLine: 1)
        
        txtEmail.font = UIFont.Poppins.medium.size(FontSize.body_15)
        txtEmail.backgroundColor = .AppColors.navigationBackground
        txtEmail.keyboardType = .emailAddress
        
        btnSendResetLink.setUp(title: "Send password reset link".Chatbotlocalized(), font: UIFont.Poppins.medium.size(FontSize.body_17), textColor: .white, bgColor: .AppColors.themeColor, radius: Constant.viewRadius4)
        btnLogin.setUp(title: "Login".Chatbotlocalized(), font: UIFont.Poppins.regular.size(FontSize.body_13), textColor: .AppColors.themeColor, bgColor: .clear)
    }
    
    private func forgotPassword(email: String) {
        ProgressHUD.show()
        self.loginViewModel.email = email
        self.loginViewModel.forgotPassword { isSuccess, error in
            ProgressHUD.dismiss()
            DispatchQueue.main.async {
                if isSuccess {
                    self.navigationController?.popViewController(animated: true)
                } else {
                    //self.showErrorToast(error)
                    self.alertMessage(title: error ?? "Oops!Something went wrong")
                }
            }
        }
    }
    func alertMessage(title:String) {
        let sb = UIStoryboard(name: "Home", bundle: nil)
        let alertVC = sb.instantiateViewController(identifier: "CustomAlertViewController") as! CustomAlertViewController
        alertVC.message = title
        alertVC.modalPresentationStyle = .overCurrentContext
        alertVC.modalTransitionStyle = .crossDissolve
       // present(vc, animated: true, completion: nil)
        present(alertVC, animated: false, completion: nil)
        
    }
    
    // MARK: - Actions
    @IBAction func onBtnPasswordResetLink(sender: UIButton) {
        
        let email = txtEmail.text ?? ""
        let validation = onboardingViewModel.validateForgotPassword(email: email)
        if let err = validation {
            self.showErrorToast(err)
        } else {
            self.forgotPassword(email: email)
        }
    }
    
    @IBAction func onBtnLogin(sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}
