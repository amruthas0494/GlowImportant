//
//  SceneDelegate.swift
//  Glow
//
//  Created by Nidhishree  on 21/10/21.
//  Copyright © 2021 CC. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    private var vwRestrict: UIView!
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        
        self.window = window
        
        // Set theme
        if let selectedTheme = UserDefaults.theme {
            window.overrideUserInterfaceStyle = selectedTheme == "dark" ? .dark : .light
        }
        
        self.configureRootViewController()
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
        self.showHideRestrictView(isShow: false)
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
        self.showHideRestrictView(isShow: true)
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
}

extension SceneDelegate {
    
    func configureRootViewController() {
        
        var storyboard = UIStoryboard(name: "Onboarding", bundle: nil)
        let navController: UINavigationController!
     
        if let userId = UserDefaults.userId, !userId.isEmpty {
            storyboard = UIStoryboard(name: "HomeTab", bundle: nil)
            let initialViewController = storyboard.instantiateViewController(withIdentifier: "HomeTabBarController") as! HomeTabBarController
            initialViewController.isShowBiometric = true
            navController = UINavigationController(rootViewController: initialViewController)
        } else {
            let initialViewController = storyboard.instantiateViewController(withIdentifier: WelcomeViewController.identifier) as! WelcomeViewController
           // initialViewController.mascotFor = .Welcome
            navController = UINavigationController(rootViewController: initialViewController)
        }
        navController.isNavigationBarHidden = true
        
        self.window?.rootViewController = navController
        self.window?.makeKeyAndVisible()
    }
    
    //MARK: Manage Restrict View
    private func showHideRestrictView(isShow:Bool = false) {
        guard let windowIs = self.window else {
            return
        }
        if isShow {
            if self.vwRestrict == nil {
                self.vwRestrict = UIView()
                self.vwRestrict.backgroundColor = .white
                self.vwRestrict.frame.size = windowIs.frame.size
                self.window?.addSubview(self.vwRestrict)
            }
        } else {
            if self.vwRestrict != nil { self.vwRestrict.removeFromSuperview()
                self.vwRestrict = nil
            }
        }
    }
}
