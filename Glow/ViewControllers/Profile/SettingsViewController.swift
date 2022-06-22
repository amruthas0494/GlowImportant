//
//  SettingsViewController.swift
//  Glow
//
//  Created by Cognitiveclouds2021_4 on 16/02/22.
//  Copyright © 2022 CC. All rights reserved.
//

import UIKit
//import LanguageManager_iOS

class SettingsViewController: UIViewController {
    
    static let identifier = "SettingsViewController"
    
    // MARK: - Outlets
    @IBOutlet weak var lblChooseTheme: UILabel!
    @IBOutlet weak var lblLight: UILabel!
    @IBOutlet weak var vwLight: UIView!
    @IBOutlet weak var imgRadioLight: UIImageView!
    @IBOutlet weak var btnLight: UIButton!
    @IBOutlet weak var lblDark: UILabel!
    @IBOutlet weak var vwDark: UIView!
    @IBOutlet weak var imgRadioDark: UIImageView!
    @IBOutlet weak var btnDark: UIButton!
    @IBOutlet weak var lblReadingFont: UILabel!
    @IBOutlet weak var img14: UIImageView!
    @IBOutlet weak var lbl14: UILabel!
    @IBOutlet weak var btn14: UIButton!
    @IBOutlet weak var img16: UIImageView!
    @IBOutlet weak var lbl16: UILabel!
    @IBOutlet weak var btn16: UIButton!
    @IBOutlet weak var img18: UIImageView!
    @IBOutlet weak var lbl18: UILabel!
    @IBOutlet weak var btn18: UIButton!
    @IBOutlet weak var img20: UIImageView!
    @IBOutlet weak var lbl20: UILabel!
    @IBOutlet weak var btn20: UIButton!
    @IBOutlet weak var languageChangelbl: UILabel!
    @IBOutlet weak var lbl21: UILabel!
    @IBOutlet weak var btn21: UIButton!
    @IBOutlet weak var img21: UIImageView!
    @IBOutlet weak var img22: UIImageView!
    @IBOutlet weak var lbl22: UILabel!
    @IBOutlet weak var btn22: UIButton!
    @IBOutlet weak var onBtnSaveChanges: UIButton!
    
    // MARK: - Variable
    var arrLanguages = Localize.availableLanguages()
    var selectedTheme: String? {
        didSet {
            if let selectedTheme = selectedTheme {
                self.imgRadioLight.image = selectedTheme == "light" ?
                UIImage(named: "radioSelected") : UIImage(named: "radio")
                self.imgRadioDark.image = selectedTheme == "dark" ?
                UIImage(named: "radioSelected") : UIImage(named: "radio")
            }
        }
    }
    var prefSize: Int? {
        didSet {
            if let prefSize = prefSize {
                self.img14.image = prefSize == 14 ? UIImage(named: "radioSelected") : UIImage(named: "radio")
                self.img16.image = prefSize == 16 ? UIImage(named: "radioSelected") : UIImage(named: "radio")
                self.img18.image = prefSize == 18 ? UIImage(named: "radioSelected") : UIImage(named: "radio")
                self.img20.image = prefSize == 20 ? UIImage(named: "radioSelected") : UIImage(named: "radio")
            }
        }
    }
    var selectedLang: String? {
        didSet {
            if let selectedLang = selectedLang {
                self.img21.image = selectedLang == "zh-Hans" ? UIImage(named: "radioSelected") : UIImage(named: "radio")
                self.img22.image = selectedLang == "en" ? UIImage(named: "radioSelected") : UIImage(named: "radio")
            }
        }
    }
    
    // MARK: - Page life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        decorateUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setTitle("Settings".localized(), isBackButton: true)
        self.prefSize = Glow.sharedInstance.prefFontSize
        self.selectedLang = Localize.currentLanguage()
        setUpModeSwitch()
    }
    
    // MARK: - Private methods
    private func decorateUI() {
        
        [lblChooseTheme, lblReadingFont, lblLight, lblDark, languageChangelbl].forEach { lbl in
            lbl?.setUp(title: "", font: UIFont.Poppins.medium.size(FontSize.body_13), textColor: UIColor.AppColors.darkTextColor, noOfLine: 0)
        }
        lblChooseTheme.text = "Choose a theme".localized()
        lblReadingFont.text = "Reading Font Size".localized()
        lblLight.text = "Light".localized()
        lblDark.text = "Dark".localized()
        lblLight.textAlignment = .center
        lblDark.textAlignment = .center
        
        
        [vwLight, vwDark].forEach { vw in
            vw?.layer.cornerRadius = Constant.viewRadius23
            vw?.layer.borderWidth = Constant.viewBorder1
            vw?.layer.borderColor = UIColor.AppColors.themeColor.cgColor
            vw?.clipsToBounds = true
        }
        
        [img14, img16, img18, img20].forEach { img in
            img?.image = UIImage(named: "radio")
        }
        [btn14, btn16, btn18, btn20].forEach { btn in
            btn?.setUpBlank()
        }
        
        lbl14.setUp(title: "14 - Hello David".localized(), font: UIFont.Poppins.medium.size(FontSize.body_14), textColor: UIColor.AppColors.grayTextColor, noOfLine: 0)
        lbl16.setUp(title: "16 - Hello David".localized(), font: UIFont.Poppins.medium.size(FontSize.body_16), textColor: UIColor.AppColors.grayTextColor, noOfLine: 0)
        lbl18.setUp(title: "18 - Hello David".localized(), font: UIFont.Poppins.medium.size(FontSize.body_18), textColor: UIColor.AppColors.grayTextColor, noOfLine: 0)
        lbl20.setUp(title: "20 - Hello David".localized(), font: UIFont.Poppins.medium.size(FontSize.title3_20), textColor: UIColor.AppColors.grayTextColor, noOfLine: 0)
        
        languageChangelbl.text = "Language Preference".localized()
        lbl21.setUp(title: "Mandarin", font: UIFont.Poppins.medium.size(FontSize.body_15), textColor: UIColor.AppColors.grayTextColor, noOfLine: 0)
        lbl22.setUp(title: "English", font: UIFont.Poppins.medium.size(FontSize.body_15), textColor: UIColor.AppColors.grayTextColor, noOfLine: 0)
        [img21, img22].forEach { img in
            img?.image = UIImage(named: "radio")
        }
        btnDark.setUpBlank()
        btnLight.setUpBlank()
        btn21.setUpBlank()
        btn22.setUpBlank()
        
        onBtnSaveChanges.setUp(title: "Save Changes".localized(), font: UIFont.Poppins.medium.size(FontSize.body_17), textColor: .white, bgColor: UIColor.AppColors.themeColor, radius: Constant.viewRadius4)
    }
    
    private func setUpModeSwitch() {
        if self.traitCollection.userInterfaceStyle == .dark {
            selectedTheme = "dark"
            imgRadioDark.image = UIImage(named: "radioSelected")
            imgRadioLight.image = UIImage(named: "radio")
        } else {
            selectedTheme = "light"
            imgRadioLight.image = UIImage(named: "radioSelected")
            imgRadioDark.image = UIImage(named: "radio")
        }
    }
    
    // MARK: - IBActions
    @IBAction func onBtnLight_Tap(sender: UIButton) {
        self.selectedTheme = "light"
    }
    
    @IBAction func onBtnDark_Tap(sender: UIButton) {
        self.selectedTheme = "dark"
    }
    
    @IBAction func onBtnFont_Tap(sender: UIButton) {
        self.prefSize = sender.tag
    }
    
    @IBAction func languagechangeBtnTapped(_ sender: UIButton) {
        self.selectedLang = sender.tag == 1 ? "zh-Hans" : "en"
    }
    
    private func viewControllerToShow() -> UIViewController {
        let storyboard = UIStoryboard(name: "HomeTab", bundle: nil)
        let navController: UINavigationController!
        
        
        let initialViewController = storyboard.instantiateViewController(withIdentifier: "HomeTabBarController") as! HomeTabBarController
        //            initialViewController.isShowBiometric = true
        navController = UINavigationController(rootViewController: initialViewController)
        return navController
    }
    
    
    @IBAction func onBtnSaveChanges(sender: UIButton) {
        if let selectedTheme = selectedTheme {
            UserDefaults.theme = selectedTheme
            (UIApplication.shared.delegate as? AppDelegate)?.changeUserInterfaceStyle(for: selectedTheme)
        }
        if let prefSize = prefSize {
            UserDefaults.prefFontSize = prefSize
            Glow.sharedInstance.prefFontSize = prefSize
        }
        if let selectedLang = selectedLang {
            Localize.setCurrentLanguage(selectedLang)
        }
       
        self.navigationController?.popViewController(animated: true)
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        self.setUpModeSwitch()
    }
    
   
}
