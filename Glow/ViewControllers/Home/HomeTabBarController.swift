//
//  HomeTabBarController.swift
//  Glow
//
//  Created by Nidhishree HP on 08/12/21.
//  Copyright © 2021 CC. All rights reserved.
//

import Foundation
import UIKit
import LocalAuthentication

class HomeTabBarController: UITabBarController, UITabBarControllerDelegate {
    
    // MARK: - Variable
    var isShowBiometric: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        self.tabBar.backgroundColor = UIColor.white//UIColor.AppColors.navigationBackground
        self.tabBar.tintColor = UIColor.AppColors.themeColor
        self.tabBar.unselectedItemTintColor = UIColor.AppColors.grayTextColor
        // Shadow to top of tab bar
        self.tabBar.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.tabBar.layer.shadowRadius = 2
        self.tabBar.layer.shadowColor = UIColor.black.cgColor
        self.tabBar.layer.shadowOpacity = 0.3
        
        if isShowBiometric {
            UserDefaults.lockScreen = "4DigitPin"
            checkForDeviceLock()
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(onLanguageChange), name: NSNotification.Name(LCLLanguageChangeNotification), object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(LCLLanguageChangeNotification), object: nil)
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        self.tabBar.backgroundColor = UIColor.AppColors.navigationBackground
    }
    
    private func checkForDeviceLock() {
        let isLockEnabled = LAContext().canEvaluatePolicy(.deviceOwnerAuthentication, error: nil)
        let userLockPref = UserDefaults.lockScreen ?? ""
        if !userLockPref.isEmpty && isLockEnabled {
            let authVC = BiometricViewController.instantiateFromAppStoryBoard(appStoryBoard: .moduleSummary)
            self.navigationController?.present(authVC, animated: true, completion: nil)
        }
    }
    
    @objc private func onLanguageChange() {
        self.tabBar.items![0].title = "Home".localized()
        self.tabBar.items![1].title = "Library".localized()
        self.tabBar.items![2].title = "Search".localized()
        self.tabBar.items![3].title = "Notification".localized()
    }
}

