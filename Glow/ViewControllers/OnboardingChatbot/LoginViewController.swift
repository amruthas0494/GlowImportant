//
//  LoginViewController.swift
//  Glow
//
//  Created by Cognitiveclouds2021_4 on 22/02/22.
//  Copyright © 2022 CC. All rights reserved.
//

import UIKit
import ProgressHUD

class LoginViewController: UIViewController {
    
    static let identifier = "LoginViewController"
    
    // MARK: - Outlets
    @IBOutlet weak var lblLogin: UILabel!
    @IBOutlet weak var lblLoginToAcc: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblPassword: UILabel!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var btnForgotPassword: UIButton!
    @IBOutlet weak var btnLoginToAcc: UIButton!
    
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
        
        lblLogin.setUp(title: "Login".Chatbotlocalized(), font: UIFont.Poppins.semiBold.size(FontSize.title1_23), textColor: .AppColors.themeColor, noOfLine: 1)
        lblLoginToAcc.setUp(title: "Login to your account!".Chatbotlocalized(), font: UIFont.Poppins.medium.size(FontSize.body_13), textColor: .darkText, noOfLine: 1)
        [lblEmail, lblPassword].forEach { lbl in
            lbl?.setUp(title: "", font: UIFont.Poppins.medium.size(FontSize.body_13), textColor: .AppColors.darkTextColor, noOfLine: 1)
        }
        lblEmail.text = "Study Number".Chatbotlocalized()
        lblPassword.text = "Password".Chatbotlocalized()
        
        [txtEmail, txtPassword].forEach { txt in
            txt?.font = UIFont.Poppins.medium.size(FontSize.body_15)
            txt?.backgroundColor = .AppColors.navigationBackground
        }
        txtEmail.keyboardType = .emailAddress
        txtPassword.isSecureTextEntry = true
        
        btnForgotPassword.setUp(title: "Forgot Password?".Chatbotlocalized(), font: UIFont.Poppins.medium.size(FontSize.body_13), textColor: .AppColors.themeColor, bgColor: .clear)
        btnLoginToAcc.setUp(title: "Login to account".Chatbotlocalized(), font: UIFont.Poppins.medium.size(FontSize.body_17), textColor: .white, bgColor: .AppColors.themeColor, radius: Constant.viewRadius4)
    }
    
    private func loginToAcc(email: String, password: String, fcmToken: String) {
        ProgressHUD.show()
        self.loginViewModel.email = email
        self.loginViewModel.password = password
        self.loginViewModel.fcmToken = fcmToken
        
        self.loginViewModel.login { isSuccess, error in
            ProgressHUD.dismiss()
            DispatchQueue.main.async {
                if isSuccess {
                 
                    //Make dashboard root
                    let storyboard = UIStoryboard(name: "HomeTab", bundle: nil)
                    let initialViewController = storyboard.instantiateViewController(withIdentifier: "HomeTabBarController")
                    let navController = UINavigationController(rootViewController: initialViewController)
                    navController.isNavigationBarHidden = true
                    if let window = UIApplication.shared.windows.first {
                        window.rootViewController = navController
                        window.makeKeyAndVisible()
                    }
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
    @IBAction func onBtnLoginToAcc(sender: UIButton) {
        
        let email = txtEmail.text ?? ""
        let password = txtPassword.text ?? ""
        let fcmToken = UserDefaults.standard.string(forKey: "fcmToken")

       // let validation = onboardingViewModel.validateSignIn(email: email, password: password)
      //  if let err = validation {
       //     self.showErrorToast(err)
      //  } else {
        self.loginToAcc(email: email, password: password, fcmToken: fcmToken ?? " ")
     //   }
        
    }
    
    @IBAction func onBtnForgotPassword(sender: UIButton) {
        if let forgotPassVC = self.storyboard?.instantiateViewController(withIdentifier: ForgotPasswordViewController.identifier) as? ForgotPasswordViewController {
            self.navigationController?.pushViewController(forgotPassVC, animated: true)
        }
    }
}
