//
//  WebViewController.swift
//  Glow
//
//  Created by Cognitiveclouds2021_4 on 16/02/22.
//  Copyright © 2022 CC. All rights reserved.
//
import UIKit
import WebKit
import SwiftKeychainWrapper
//import ProgressHUD

class WebViewController: UIViewController {
    
    static let identifier = "WebViewController"
    
    // MARK: - Outlet
    @IBOutlet weak var vwWeb: UIView!
    var webView: WKWebView!
    
    // MARK: - Variables
    var webUnitViewModel = UnitViewModel()
    
    var objUnit: Unit?
    var arrUnit = [Unit]()
    var pageId: String?
    var loaded = false
    var isFromWeb: Bool?
    
    // MARK: - Page life cycle
    override func loadView() {
        super.loadView()
                
        let webConfiguration = WKWebViewConfiguration()
        let contentController = WKUserContentController()
        contentController.add(self, name: "callbackHandler")
        webConfiguration.userContentController = contentController
        
        webView = WKWebView(frame: self.vwWeb.bounds, configuration: webConfiguration)
        webView.uiDelegate = self
        webView.navigationDelegate = self
        webView.allowsBackForwardNavigationGestures = true
        webView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        if #available(iOS 14.0, *) {
            webView.configuration.defaultWebpagePreferences.allowsContentJavaScript = true
        }
        self.vwWeb.addSubview(webView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let strUrl = self.objUnit?.webUrl, let pageId = pageId {
            let urlIs = strUrl + "&pageId=\(pageId)"
            if let url = URL(string: urlIs) {
                self.loadWebview(url: url)
                return
            }
        }
        if let webUrl = self.objUnit?.webUrl, let url = URL(string: webUrl) {
            self.loadWebview(url: url)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setTitle(self.objUnit?.title ?? "", isBackButton: true)
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        webView.scrollView.contentInset = UIEdgeInsets.zero
    }
    
    // MARK: - Methods
    func load() {
        if !loaded {
            webView.reload()
        }
        loaded = true
    }
    
    func loadWebview(url: URL) {
        if let token = KeychainWrapper.standard.string(forKey: Constant.loginConstants.authToken),
           let userId = UserDefaults.standard.string(forKey: Constant.loginConstants.userId) {
            //            if isBookmarked {
            //                if let lessonId = self.lessonViewModel.lessonID, let projectId = self.lessonViewModel.projectId, let pageId = self.lessonViewModel.pageId, let status = self.lessonViewModel.status {
            //                    //return "http://ec2-54-221-22-252.compute-1.amazonaws.com:4000"
            //                    let url = URL(string: "https://hero-stg-fe-7m4wybox7a-as.a.run.app/home/read/lesson/\(lessonId)?projectId=\(projectId)&pageId=\(pageId)&status=\(status)")!
            //                    let addCookieScript="localStorage.setItem('token', '\(token)')\n"
            //
            //                    let script: WKUserScript = WKUserScript(source: addCookieScript as String, injectionTime: .atDocumentStart, forMainFrameOnly: false)
            //                    let config = lessonWebView.configuration
            //                    config.userContentController.addUserScript(script)
            //                    self.lessonWebView.evaluateJavaScript("localStorage.setItem(\"token\", \"\(token)\")") { (result, error) in
            //                        self.lessonWebView.evaluateJavaScript("localStorage.setItem(\"userId\", \"\(userId)\")") { (result, error) in}}
            //                    loadPage(url: url)
            //                }
            //            } else {
            //                if let lessonId = self.lessonViewModel.lessonID, let projectId = self.lessonViewModel.projectId, let status = self.lessonViewModel.status {
            
            let addCookieScript="localStorage.setItem('token', '\(token)')\n"
            let script: WKUserScript = WKUserScript(source: addCookieScript as String, injectionTime: .atDocumentStart, forMainFrameOnly: false)
            let config = webView.configuration
            config.userContentController.addUserScript(script)
            self.webView.evaluateJavaScript("localStorage.setItem(\"token\", \"\(token)\")") { (result, error) in
                self.webView.evaluateJavaScript("localStorage.setItem(\"userId\", \"\(userId)\")") { (result, error) in
                    self.webView.evaluateJavaScript("localStorage.setItem(\"mobileOs\", \"ios\")") { res, err in
                        
                    }
                }
                
            }
            loadPage(url: url)
            unitStartEnd(type: "unit_start")
            //                }
            //            }
        }
    }
    
    func loadPage(url: URL) {
        ProgressHUD.show()
        let request = NSMutableURLRequest(url: url as URL, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 60.0)
        if let token = KeychainWrapper.standard.string(forKey: Constant.loginConstants.authToken),
           let userId = UserDefaults.standard.string(forKey: Constant.loginConstants.userId) {
            webView.evaluateJavaScript("localStorage.getItem(\"key\")") { (result, error) in
                if error == nil{
                    self.webView.evaluateJavaScript("localStorage.setItem(\"token\", \"\(token)\")") { (result, error) in
                        self.webView.evaluateJavaScript("localStorage.setItem(\"userId\", \"\(userId)\")") { (result, error) in
                            self.webView.evaluateJavaScript("localStorage.setItem(\"mobileOs\", \"ios\")") { res, err in
                                
                                DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                                    
                                    self.webView.load(request as URLRequest)
                                }
                            }
                        }
                    }
                } else {
                    self.webView.load(request as URLRequest)
                }
            }
        }
    }
    
    // MARK: - API Calls
    private func unitStartEnd(type: String) {
        ProgressHUD.show()
        webUnitViewModel.lessonId = self.objUnit?.educationLessonId
        webUnitViewModel.educationLessonUnitId = self.objUnit?.id
        webUnitViewModel.type = type
        webUnitViewModel.webunitStartEnd { (isSuccess, error) in
            ProgressHUD.dismiss()
            DispatchQueue.main.async {
                if !isSuccess {
                   // self.showErrorToast(error)
                    self.alertMessage(title: error ?? "Oops!Something went wrong")

                } else {
                    if type == "unit_end" {
                        let vc = ReflectionJournalViewController.instantiateFromAppStoryBoard(appStoryBoard: .moduleSummary)
                        vc.journalViewModel.lessonId = self.objUnit?.educationLessonId
                        vc.journalViewModel.unitId = self.objUnit?.id
                        vc.journalViewModel.arrUnit = self.arrUnit
                        self.navigationController?.pushViewController(vc, animated: true)
                    }
                }
            }
        }
    }
    
    func alertMessage(title:String) {
        let sb = UIStoryboard(name: "Home", bundle: nil)
        let alertVC = sb.instantiateViewController(identifier: "CustomAlertViewController") as! CustomAlertViewController
        alertVC.modalPresentationStyle = .overCurrentContext
        alertVC.modalTransitionStyle = .crossDissolve
       // present(vc, animated: true, completion: nil)
        present(alertVC, animated: false, completion: nil)
        
    }
}

// MARK: - WKNavigationDelegate
extension WebViewController: WKNavigationDelegate, WKUIDelegate, WKScriptMessageHandler {
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        if let token = KeychainWrapper.standard.string(forKey: Constant.loginConstants.authToken),
           let userId = UserDefaults.standard.string(forKey: Constant.loginConstants.userId) {
            webView.evaluateJavaScript("localStorage.getItem(\"key\")") { (result, error) in
                if error == nil{
                    webView.evaluateJavaScript("localStorage.setItem(\"token\", \"\(token)\")") { (result, error) in
                        webView.evaluateJavaScript("localStorage.setItem(\"userId\", \"\(userId)\")") { (result, error) in
                            self.webView.evaluateJavaScript("localStorage.setItem(\"mobileOs\", \"ios\")") { res, err in
                                
                            }
                        }
                    }
                } else {
                    print(error as Any)
                }
            }
        }
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        if let token = KeychainWrapper.standard.string(forKey: Constant.loginConstants.authToken),
           let userId = UserDefaults.standard.string(forKey: Constant.loginConstants.userId) {
            DispatchQueue.main.async {
                
                webView.evaluateJavaScript("localStorage.getItem(\"key\")") { (result, error) in
                    if error == nil {
                        webView.evaluateJavaScript("localStorage.setItem(\"token\", \"\(token)\")") { (result, error) in
                            webView.evaluateJavaScript("localStorage.setItem(\"userId\", \"\(userId)\")") { (result, error) in
                                self.webView.evaluateJavaScript("localStorage.setItem(\"mobileOs\", \"ios\")") { res, err in
                                    
                                }
                            }
                            self.load()
                            ProgressHUD.dismiss()
                        }
                    } else {
                        print(error as Any)
                    }
                }
            }
        }
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if navigationAction.request.url?.scheme == "tel" {
            UIApplication.shared.open(navigationAction.request.url!, options: [:], completionHandler: nil)
            decisionHandler(.cancel)
        } else {
            decisionHandler(.allow)
        }
        switch navigationAction.navigationType {
        case .linkActivated:
            if navigationAction.targetFrame == nil {
                self.webView?.load(navigationAction.request)// It will load that link in same WKWebView
            }
        default:
            break
        }
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        print(error)
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        ProgressHUD.dismiss()
        print(error.localizedDescription)
    }
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        print(message.name, message.body)
        if message.name == "callbackHandler" {
            unitStartEnd(type: "unit_end")
        }
    }
}
