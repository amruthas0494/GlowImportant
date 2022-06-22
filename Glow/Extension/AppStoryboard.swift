//
//  AppStoryboard.swift
//  MovieDemoApp
//
//  Created by Harsha on 7/6/19.
//  Copyright © 2019 Skylor Lane. All rights reserved.
//

import Foundation
import UIKit

enum AppStoryboard : String {
    
    case home = "Home"
    case library = "Library"
    case search  = "Search"
    case profile = "Profile"
    case notification = "Notification"
    case hometab = "HomeTab"
    case onboardingChatbot = "OnboardingChatbot"
    case topics = "Topics"
    case moduleSummary = "ModuleSummary"
    case onboarding = "Onboarding"
    
    var instance : UIStoryboard {
        return UIStoryboard(name: self.rawValue, bundle: Bundle.main)
    }
    
    func viewController<T: UIViewController>(viewcontrollerClass: T.Type) -> T {
        let storyBoardId =  (viewcontrollerClass as UIViewController.Type).storyboardID
        let controller = instance.instantiateViewController(withIdentifier: storyBoardId) as! T
        return controller
    }
}

extension UIViewController {
    
    class var storyboardID : String {
        return "\(self)"
    }
    
    static func instantiateFromAppStoryBoard(appStoryBoard: AppStoryboard) -> Self {
        return appStoryBoard.viewController(viewcontrollerClass: self)
    }
}
