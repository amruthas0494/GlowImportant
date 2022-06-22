//
//  UIViewController+Extension.swift
//  Skylor
//
//  Created by Ramprasad A on 8/14/19.
//  Copyright © 2019 Skylor Lane. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation
import Kingfisher
import Loaf

extension UIViewController {
    

//    func topMostViewController() -> UIViewController {
//        if let presented = self.presentedViewController {
//            return presented.topMostViewController()
//        }
//
//        if let navigation = self as? UINavigationController {
//            return navigation.visibleViewController?.topMostViewController() ?? navigation
//        }
//
//        if let tab = self as? UITabBarController {
//            return tab.selectedViewController?.topMostViewController() ?? tab
//        }
//
//        return self
//    }

//    @objc func networkStatusChanged(_ notification: Notification) {
//           if let userInfo = notification.userInfo {
//               if let status = userInfo["Status"] as? String {
//               print(status)
//                   if status == "Offline"{
//                   self.showAlertWith(msg: "The internet connection appears to be offline", btnTitles: [.OK], type: .alert) { (data) in
//                       print(data)
//                   }
//                   }
//               }
//           }
//
//       }
//    func setStatusBarStyle(_ style: UIStatusBarStyle) {
//            if let statusBar = UIApplication.shared.value(forKey: "statusBar") as? UIView {
//                statusBar.backgroundColor = style == .lightContent ? UIColor.black : .white
//                statusBar.setValue(style == .lightContent ? UIColor.white : .black, forKey: "foregroundColor")
//            }
//        }
//
//    @objc func dismissKeyboard() {
//        view.endEditing(true)
//        //sender.cancelsTouchesInView = false
//    }
//
  
    
    
    func setTitle(_ title:String, isBackButton: Bool = false) {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
       
        
        UINavigationBar.appearance().standardAppearance = navBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
      
        
        self.navigationController?.isNavigationBarHidden = false
        let fullTitle = NSMutableAttributedString()
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        let titleString = NSAttributedString(string: title as String, attributes: [.font:  UIFont.Poppins.medium.size(FontSize.body_17), .foregroundColor: UIColor.AppColors.blackText , .paragraphStyle: paragraphStyle])
        fullTitle.append(titleString)
        
        let navTextView = UIView()
        
        let titleLbl = UILabel()
        titleLbl.attributedText = fullTitle
        titleLbl.numberOfLines = 0
        titleLbl.lineBreakMode = .byWordWrapping
        titleLbl.sizeToFit()
        titleLbl.textAlignment = .center
        
        let titleBtn = UIButton.init(frame: titleLbl.frame)
        navTextView.frame = titleLbl.frame
        navTextView.addSubview(titleLbl)
        navTextView.addSubview(titleBtn)
        self.navigationItem.titleView = nil
        self.navigationItem.titleView = navTextView
        
       // UINavigationBar.appearance().barTintColor = navBarAppearance
       // self.navigationController?.navigationBar.barTintColor = UIColor.AppColors.navigationBackground
        self.navigationController?.navigationBar.topItem?.title = ""        
        
        if isBackButton {
            let imgBack = UIImage(named: "back")
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: imgBack, style: .plain, target: self, action: #selector(onBtnBackTap))
        } else {
            self.navigationItem.backBarButtonItem = nil
        }
    }
    
    func setUpNavRightBar(image: [String], tags: [Int]) {
        
        var barButtonItems = [UIBarButtonItem]()
        for (index, image) in image.enumerated() {
            let rightButtonItem = UIBarButtonItem(image: UIImage(named: image), style: .plain, target: self, action: #selector(onBtnRightClick(sender:)))
            rightButtonItem.tag = tags[index]
            barButtonItems.append(rightButtonItem)
        }
        self.navigationItem.rightBarButtonItems = barButtonItems
    }
    
    func setUpNavRightBar(titles: [String], tags: [Int]) {
        
        var barButtonItems = [UIBarButtonItem]()
        for (index, title) in titles.enumerated() {
            let rightButtonItem = UIBarButtonItem(title: title, style: .plain, target: self, action: #selector(onBtnRightClick(sender:)))
            rightButtonItem.tag = tags[index]
            barButtonItems.append(rightButtonItem)
        }
        self.navigationItem.rightBarButtonItems = barButtonItems
    }
    
    @objc func onBtnRightClick(sender: UIBarButtonItem) {
        
    }
    
    @objc func onBtnBackTap() {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    func setLeftAlignedNavigationItemTitle(text: String,
                                               color: UIColor,
                                               margin left: CGFloat)
        {
            let titleLabel = UILabel()
            titleLabel.textColor = color
            titleLabel.text = text
            titleLabel.textAlignment = .left
            titleLabel.translatesAutoresizingMaskIntoConstraints = false
            
            self.navigationItem.titleView = titleLabel
            
            guard let containerView = self.navigationItem.titleView?.superview else { return }
            
            // NOTE: This always seems to be 0. Huh??
            let leftBarItemWidth = self.navigationItem.leftBarButtonItems?.reduce(0, { $0 + $1.width })
            
            NSLayoutConstraint.activate([
                titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor),
                titleLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
                titleLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor,
                                                 constant: (leftBarItemWidth ?? 0) + left),
                titleLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor)
            ])
        }
    
//    func parentController(containerView:UIView ,childController:UIViewController) {
//        self.addChild(childController)
//        containerView.addSubview(childController.view)
//        let frame:CGRect = containerView.bounds
//        childController.view.frame = frame
//        childController.didMove(toParent: self)
//    }
//
//    @discardableResult func makeHomeAsRootViewController() -> HomeTabBarController {
//        let rootVC = HomeTabBarController.instantiateFromAppStoryBoard(appStoryBoard: .home)
//        let navCtr = UINavigationController.init(rootViewController: rootVC)
//        navCtr.setNavigationBarHidden(true, animated: true)
//        UIApplication.shared.keyWindow?.rootViewController = nil
//        UIApplication.shared.keyWindow?.rootViewController = navCtr
//        UIApplication.shared.keyWindow?.makeKeyAndVisible()
//        return rootVC
//    }
    
//    @discardableResult func makeLoginAsRootViewController() -> LoginViewController {
//        let rootVC = LoginViewController.instantiateFromAppStoryBoard(appStoryBoard: .login)
//        let navCtr = UINavigationController.init(rootViewController: rootVC)
//        navCtr.setNavigationBarHidden(true, animated: true)
//        UIApplication.shared.keyWindow?.rootViewController = nil
//        UIApplication.shared.keyWindow?.rootViewController = navCtr
//        UIApplication.shared.keyWindow?.makeKeyAndVisible()
//        return rootVC
//    }
//
//    @discardableResult func makePermissionAsRootTabViewController() -> PermissionRequestViewController {
//        let rootVC = PermissionRequestViewController.instantiateFromAppStoryBoard(appStoryBoard: .login)
//        let navCtr = UINavigationController.init(rootViewController: rootVC)
//        navCtr.setNavigationBarHidden(true, animated: true)
//        UIApplication.shared.keyWindow?.rootViewController = nil
//        UIApplication.shared.keyWindow?.rootViewController = navCtr
//        UIApplication.shared.keyWindow?.makeKeyAndVisible()
//        return rootVC
//    }
//    @discardableResult func makeConsentAsRootTabViewController() -> StudyInfoConsentViewController {
//        let rootVC = StudyInfoConsentViewController.instantiateFromAppStoryBoard(appStoryBoard: .login)
//        let navCtr = UINavigationController.init(rootViewController: rootVC)
//        rootVC.loginType = .loginAccount
//        navCtr.setNavigationBarHidden(true, animated: true)
//        UIApplication.shared.keyWindow?.rootViewController = nil
//        UIApplication.shared.keyWindow?.rootViewController = navCtr
//        UIApplication.shared.keyWindow?.makeKeyAndVisible()
//        return rootVC
//    }
    func removeChildController(_ childController: UIViewController, fromContainerView containerView: UIView) -> Void {
        childController.willMove(toParent: nil)
        let containerConstraints: Array =  containerView.constraints
        unowned let childView: UIView = childController.view
        let l_predicate: NSPredicate = NSPredicate {
            (evaluatedObject, bindings) -> Bool in
            let l_array = evaluatedObject as? [UIView]
            return l_array?.first === childView
        }
        let l_constraints: Array = containerConstraints.filter { l_predicate.evaluate(with: $0) }
        containerView.removeConstraints(l_constraints)
        childView.removeFromSuperview()
        childController.removeFromParent()
    }
//    func showAlertWith(msg: String? = nil, btnTitles: [ActionSheetActionType],type:UIAlertController.Style, _ completionHandler: @escaping (_ type: ActionSheetActionType) -> Void){
//        let alert = UIAlertController(
//            title: nil,
//            message:msg,
//            preferredStyle: type)
//
//        let handler = { (action: UIAlertAction) in
//            if let type = ActionSheetActionType(rawValue: action.title ?? "") {
//                completionHandler(type)
//            }
//        }
//
//        for anitem in 0..<btnTitles.count {
//            var style = UIAlertAction.Style.default
//            if btnTitles[anitem] == .cancel{
//                style = .cancel
//            } else {
//                style = .default
//            }
//            let action = UIAlertAction(title: btnTitles[anitem].rawValue, style: style, handler: handler)
//            alert.addAction(action)
//
//        }
//        self.present(alert, animated: true, completion: nil)
//    }
    
    
//    func displayAlert(title: String, message: String, alertType: AlertActionType?) {
//        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {action in
//            switch alertType {
//            case .logoutType? :  print("logout")
//                                 alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
//            case .shareType?:    self.dismiss(animated: false, completion: nil)
//                                 alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
//            case .alertWithOnlyOK?: print("videoFileSize")
//                                  alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
//            case .none: break
//            }
//        }))
//        self.present(alert, animated: true)
//    }
//    func activityIndicator(show: Bool = true)   {
//        DispatchQueue.main.async{
//            let mainContainer: UIView = UIView(frame: self.view.frame)
//            mainContainer.center = self.view.center
//            mainContainer.backgroundColor = UIColor.white.withAlphaComponent(0.1)
//            mainContainer.tag = 789456123
//            mainContainer.isUserInteractionEnabled = true
//
//            let viewBackgroundLoading: UIView = UIView(frame: CGRect(x:0,y: 0,width: 80,height: 80))
//            viewBackgroundLoading.center = self.view.center
//            viewBackgroundLoading.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
//            viewBackgroundLoading.alpha = 0.5
//            viewBackgroundLoading.clipsToBounds = true
//            viewBackgroundLoading.layer.cornerRadius = 15
//
//            let activityIndicatorView: UIActivityIndicatorView = UIActivityIndicatorView()
//            activityIndicatorView.frame = CGRect(x:0.0,y: 0.0,width: 40.0, height: 40.0)
//            activityIndicatorView.transform = CGAffineTransform(scaleX: 2, y: 2)
//            activityIndicatorView.style =
//                UIActivityIndicatorView.Style.gray
//            activityIndicatorView.color = UIColor.AppColor.Color.tabBlue.colorVal()
//            activityIndicatorView.center = CGPoint(x: viewBackgroundLoading.frame.size.width / 2, y: viewBackgroundLoading.frame.size.height / 2)
//            if show {
//                if !self.view.subviews.contains(where: { $0.tag == 789456123 } ) {
//                    viewBackgroundLoading.addSubview(activityIndicatorView)
////                    let label = UILabel()
////                   label.textColor = UIColor.black
////                   label.text = "LOADING"
////                   label.font = UIFont(name: "Avenir Light", size: 10)
////                   label.sizeToFit()
////                   label.center = CGPoint(x: activityIndicatorView.center.x, y: activityIndicatorView.center.y + 30)
////
////                    //label.frame = viewBackgroundLoading.frame
////                    label.text = "Loading"
////                   viewBackgroundLoading.addSubview(label)
//                    mainContainer.addSubview(viewBackgroundLoading)
//
//                    self.view.addSubview(mainContainer)
//                }
//                activityIndicatorView.startAnimating()
//            }else{
//                for subview in self.view.subviews{
//                    if subview.tag == 789456123 {
//                        subview.removeFromSuperview()
//                    }
//                }
//            }
//        }
//    }
   
    func resolutionForLocalVideo(url: URL) -> Double {
        let data = NSData(contentsOf: url)!
        let fileSize = Double(data.length / 1048576) //Convert in to MB
        print("File size in MB: ", fileSize)
        return fileSize
    }
    
//    func checkForReachability() -> Bool {
//        return Reachability()?.isConnectedToNetwork() ?? true
//    }
//    func setInternetConnectionStatusViewWithNavigationBar(){
//         DispatchQueue.main.async {
//          let view = self.addNoInternetViewWithNavigation()
//        self.checkForReachability() ? self.hideNoInternetViewWithNavigation(viewRef: view) : self.showNoInternetViewWithNavigation(viewRef: view)
//        }
//    }
//
//    func setInternetConnectionStatusView(){
//        DispatchQueue.main.async {
//            let view = self.addView()
//            self.checkForReachability() ? self.hideNoInternetView(viewRef: view) : self.showNoInternetView(viewRef: view)
//        }
//    }
//    func setNoResultView(show: Bool){
//        DispatchQueue.main.async {
//            let view = self.NoResultAddView()
//            self.showNoResultView(viewRef: view)
//            if !show{
//                self.hideNoResultView(viewRef: view)
//            }
//        }
//
//    }
    
    func showSuccessToast(_ message: String) {
        Loaf(message, state: .custom(.init(backgroundColor: UIColor.AppColors.successToast, textColor: .white, tintColor: .white, font: UIFont.Poppins.semiBold.size(FontSize.body_15), icon: UIImage(named: "success"), textAlignment: .left, iconAlignment: .left, width: .screenPercentage(0.9))), location: .bottom, sender: self).show()
    }
    
    func showErrorToast(_ message: String?) {
        let message = message ?? "Something went wrong"
        Loaf(message, state: .custom(.init(backgroundColor: UIColor.AppColors.errorToast, textColor: .white, tintColor: .white, font: UIFont.Poppins.semiBold.size(FontSize.body_15), icon: UIImage(named: "error"), textAlignment: .left, iconAlignment: .left, width: .screenPercentage(0.9))), location: .top, sender: self).show()
    }
}

//extension UIViewController: InterNetConnectionViewEvents{
//    func retryButtonTapped() {
//    }
//}
//
//extension UIViewController: InterNetConnectionViewLodable {
//
//}
//extension UIViewController: NoResultViewEvents{
//    func retrySearchButtonTapped() {
//    }
//}
//
//extension UIViewController: NoResultViewLodable {
//
//}
//extension UIViewController: NoResultsNavViewLodable {
//
//}
//extension UIViewController: NoResultsNavViewEvents {
//    func tryAgainTapped() {
//
//    }
//}
//
//class KeyboardAccessoryToolbar: UIToolbar {
//    convenience init() {
//        self.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 20))
//        self.barStyle = .default
//        self.isTranslucent = true
//        self.tintColor = UIColor.AppColor.Color.tabBlue.colorVal()
//
//        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(self.done))
//       // let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(self.cancel))
//        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
//        self.items = [spaceButton, doneButton]
//
//        self.isUserInteractionEnabled = true
//        self.sizeToFit()
//    }
//
//    @objc func done() {
//        // Tell the current first responder (the current text input) to resign.
//        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
//    }
//
//    @objc func cancel() {
//        // Call "cancel" method on first object in the responder chain that implements it.
//        UIApplication.shared.sendAction(#selector(cancel), to: nil, from: nil, for: nil)
//    }
//}
