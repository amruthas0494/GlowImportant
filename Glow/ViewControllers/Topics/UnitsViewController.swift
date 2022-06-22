//
//  UnitsViewController.swift
//  Glow
//
//  Created by Pushpa Yadav on 22/12/21.
//  Copyright © 2021 CC. All rights reserved.
//

import UIKit

protocol navigationDelegate {
    func navigatetoNext()
}
class UnitsViewController: UIViewController {

    
    static let identifier = "UnitsViewController"
    private let chatbotViewModel = ChatbotViewModel()

    
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Variables
    var objUnitViewModel = UnitViewModel()
    var arrUnits = [Unit]()
    var eachUnit : Unit?
    var timer = Timer()
   // var delegate : navigationDelegate?
    
    // MARK: - Page life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
        
        getLessonUnits()
       // self.delegate?.navigatetoNext()
    }
    
    // MARK: - Get units by lesson ID
    private func getLessonUnits() {
        ProgressHUD.show()
        objUnitViewModel.getLessonUnit { isSuccess, errMessage, arrUnits in
            ProgressHUD.dismiss()
            DispatchQueue.main.async {
                if isSuccess {
                    self.arrUnits = arrUnits ?? []
                    self.tableView.reloadData()
                } else {
                   // self.showErrorToast(errMessage)
                    self.alertMessage(title: errMessage ?? "Oops!Something went wrong")
                    
                }
            }
        }
    }
    
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension UnitsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrUnits.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withClass: UnitsCell.self, for: indexPath)
        cell.selectionStyle = .none
        cell.objUnit = arrUnits[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let object = arrUnits[indexPath.row]
        self.eachUnit = object
       
        let adaptiveChatBot = UIStoryboard(name: "OnboardingChatbot", bundle: nil)
        
        if object.initBotId != nil && object.progress == nil {
            print("Move to chatbot")
         
            if let chatBotVC = adaptiveChatBot.instantiateViewController(withIdentifier: DynamicChatbotViewController.identifier) as? DynamicChatbotViewController {
                chatBotVC.botId = object.initBotId
                chatBotVC.objUnit = object
                chatBotVC.arrUnits = self.arrUnits
                chatBotVC.modalPresentationStyle = .fullScreen
                self.navigationController?.present(chatBotVC, animated: true, completion: nil)
            }
        }
        timer = Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(navigatetoWebView), userInfo: nil, repeats: false)
       
  
        
    }
    @objc func navigatetoWebView() {
        let topicSB = UIStoryboard(name: "Topics", bundle: nil)
        if let webVC = topicSB.instantiateViewController(withIdentifier: WebViewController.identifier) as? WebViewController {
            webVC.objUnit = eachUnit
            webVC.arrUnit = self.arrUnits
            self.navigationController?.pushViewController(webVC, animated: true)
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
