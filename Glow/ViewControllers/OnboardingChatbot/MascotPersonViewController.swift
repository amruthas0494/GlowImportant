//
//  MascotPersonViewController.swift
//  Glow
//
//  Created by Pushpa Yadav on 09/12/21.
//  Copyright © 2021 CC. All rights reserved.
//

import UIKit
import IOSSecuritySuite

enum MascotFor: Int {
    case Welcome, ThankYou
}

class MascotPersonViewController: UIViewController {
    
    static let identifier = "MascotPersonViewController"
    
    // MARK: - Outlets
    @IBOutlet weak var imgPerson: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDesc: UILabel!
    @IBOutlet weak var btnDone: UIButton!
    
    var mascotFor: MascotFor = .Welcome
    
    // MARK: - Page life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        decorateUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
        if mascotFor == .Welcome {
            self.lblTitle.text = "Hello!\nI am sister Jenni".Chatbotlocalized()
            self.lblDesc.text = "There are few questions you need to answer. It might take a bit of time. Would you like to start?".Chatbotlocalized()
            self.btnDone.setUp(title: "Continue".Chatbotlocalized(), font: UIFont.Poppins.medium.size(FontSize.body_17), textColor: .white, bgColor: UIColor.AppColors.themeColor, radius: Constant.viewRadius4)
        } else {
            self.lblTitle.text = "Thank you!".Chatbotlocalized()
            self.lblDesc.text = "For taking out the time to complete all the steps.".Chatbotlocalized()
            self.btnDone.setUp(title: "Done".Chatbotlocalized(), font: UIFont.Poppins.medium.size(FontSize.body_17), textColor: .white, bgColor: UIColor.AppColors.themeColor, radius: Constant.viewRadius4)
        }
        
        // FIXME: While submitting app to store uncomment below check
//        self.checkForJailbroken()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        DispatchQueue.main.async {
            self.imgPerson.layer.cornerRadius = self.imgPerson.frame.height/2
            self.imgPerson.clipsToBounds = true
        }
    }
    
    // MARK: - Private methods
    private func decorateUI() {
        imgPerson.image = UIImage(named: "sisterJenny")
        imgPerson.layer.borderWidth = Constant.viewBorder5
        imgPerson.layer.borderColor = UIColor.AppColors.EDC7F5.cgColor
        
        lblTitle.setUp(title: "", font: UIFont.Poppins.semiBold.size(FontSize.largeTitle_24), textColor: UIColor.AppColors.darkTextColor, noOfLine: 0)
        lblDesc.setUp(title: "", font: UIFont.Poppins.medium.size(FontSize.body_13), textColor: UIColor.AppColors.grayTextColor, noOfLine: 0)
    }
    
    private func checkForJailbroken() {
        let runInEmulator: Bool = IOSSecuritySuite.amIRunInEmulator()
        if runInEmulator {
            DispatchQueue.main.async {
                let alert = UIAlertController(title: "Caution!", message: "Running on Emulator", preferredStyle: UIAlertController.Style.alert)
                self.present(alert, animated: true, completion: nil)
            }
        }
        let amIReverseEngineered: Bool = IOSSecuritySuite.amIReverseEngineered()
        if amIReverseEngineered {
            DispatchQueue.main.async {
                let alert = UIAlertController(title: "Caution!", message: "Reverse Engineered", preferredStyle: UIAlertController.Style.alert)
                self.present(alert, animated: true, completion: nil)
            }
        }
        let amIDebugged: Bool = IOSSecuritySuite.amIDebugged()
        if amIDebugged  {
            DispatchQueue.main.async {
                let alert = UIAlertController(title: "Caution!", message: "Debugger attached!", preferredStyle: UIAlertController.Style.alert)
                self.present(alert, animated: true, completion: nil)
            }
        }
        if isDeviceJailBroken() {
            let alert = UIAlertController(title: "Caution!", message: "This device appears to be jailbroken. There are inherent risks with jailbroken devices. To continue using this application we sugegst you to use a different device which is not jail broken.", preferredStyle: UIAlertController.Style.alert)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func isDeviceJailBroken() ->Bool {
        if access("/Applications/Cydia.app", F_OK) != -1 ||
            access("/Applications/blackra1n.app", F_OK) != -1 || access("/Applications/FakeCarrier.app", F_OK) != -1 || access("/Applications/Icy.app", F_OK) != -1 || access("/Applications/IntelliScreen.app", F_OK) != -1 || access("/Applications/MxTube.app", F_OK) != -1 || access("/Applications/RockApp.app", F_OK) != -1 || access("/Applications/SBSettings.app", F_OK) != -1 || access("/Applications/WinterBoard.app", F_OK) != -1 || access("/Library/MobileSubstrate/MobileSubstrate.dylib", F_OK) != -1 || access("/Library/MobileSubstrate/DynamicLibraries/LiveClock.plist", F_OK) != -1 || access("/Library/MobileSubstrate/DynamicLibraries/Veency.plist", F_OK) != -1 || access("/private/var/lib/apt", F_OK) != -1 || access("/private/var/lib/cydia", F_OK) != -1 || access("/private/var/mobile/Library/SBSettings/Themes", F_OK) != -1 || access("/private/var/stash", F_OK) != -1 || access("/private/var/tmp/cydia.log", F_OK) != -1 || access("/System/Library/LaunchDaemons/com.ikey.bbot.plist", F_OK) != -1 || access("/System/Library/LaunchDaemons/com.saurik.Cydia.Startup.plist", F_OK) != -1 || access("/usr/bin/sshd", F_OK) != -1 || access("/usr/libexec/sftp-server", F_OK) != -1 || access("/usr/sbin/sshd", F_OK) != -1 || access("/bin/bash", F_OK) != -1 || access("/etc/apt", F_OK) != -1 {
            return true
        }
        return false
    }
    
    // MARK: - Actions
    @IBAction func onBtnDone(sender: UIButton) {
        if mascotFor == .Welcome {
            if let onboardingChatbotVC = self.storyboard?.instantiateViewController(withIdentifier: OnboardingChatbotViewController.identifier) as? OnboardingChatbotViewController {
                self.navigationController?.pushViewController(onboardingChatbotVC, animated: true)
            }
        } else {
            if let loginVc = self.storyboard?.instantiateViewController(withIdentifier: LoginViewController.identifier) as? LoginViewController {
                self.navigationController?.pushViewController(loginVc, animated: true)
            }
        }
    }
}

extension String{
    func Chatbotlocalized() -> String {
        return NSLocalizedString(self, tableName: "OnboardingChatbot", bundle: .main, value: self, comment: self)
    }
}
