//
//  NotificationListViewController.swift
//  Glow
//
//  Created by Pushpa Yadav on 07/12/21.
//  Copyright © 2021 CC. All rights reserved.
//

import UIKit
import CoreAudio

class NotificationListViewController: UIViewController {
    
    static let identifier = "NotificationListViewController"
    
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Variables
    var sections = ["New", "Earlier"]
    let notificationViewModel = NotificationViewModel()
    var notifications: NotificationData?
    var readNotificatins: ReadNotifications?
   // var readNot: Notifications?
    //var unreadNot: Notifications?
    //   var readNotifaction: NotificationList?
    
    // MARK: - Page life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
        getNotifications()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
        self.setTitle("Notifications".localized())
        getNotifications()
        self.tableView.reloadData()
    }
    
    
    
    // MARK: - Private methods
    private func setUpTableView() {
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        if #available(iOS 15.0, *) {
            self.tableView.sectionHeaderTopPadding = 0
            self.tableView.sectionFooterHeight = 0
        }
    }
    
    func getNotifications () {
        ProgressHUD.show()
        notificationViewModel.getNotification { isSuccess, error, Notificationlist in
            ProgressHUD.dismiss()
            DispatchQueue.main.async {
                if isSuccess {
                    DispatchQueue.main.async {
                        self.notifications = Notificationlist
                        self.tableView.reloadData()
                    }
                }
                else {
                    self.showErrorToast(error)
                    // self.alertMessage(title: error ?? "Oops!Something went wrong")
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
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension NotificationListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if self.notifications?.unreadCount == 0 && sections.count == 2{
            self.sections.remove(at: 0)
        }
        if self.notifications?.unreadCount != 0 && sections.count == 1{
            self.sections.insert("New", at: 0)
        }
        if ((self.notifications?.count ?? 0) - (self.notifications?.unreadCount ?? 0)) == 0 && sections.count == 2{
            self.sections.remove(at: 1)
        }
        if self.notifications?.unreadCount == 0 && sections.count == 1{
            self.sections.remove(at: 0)
            self.sections.insert("Earlier", at: 0)
        }
        return self.sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0{
            
            if self.notifications?.unreadCount == 0{
                let number =  ((self.notifications?.count ?? 0) - (self.notifications?.unreadCount ?? 0))
                return number
            }else{
                return self.notifications?.unreadCount ?? 0
            }
        }else{
            let number =  ((self.notifications?.count ?? 0) - (self.notifications?.unreadCount ?? 0))
            return number
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UIDevice.current.userInterfaceIdiom == .phone ? 40 : 80
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let vwHeader = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 40))
        vwHeader.backgroundColor = UIColor.AppColors.navigationBackground
        let lblTitle = UILabel(frame: CGRect(x: 16, y: 0, width: tableView.frame.width - 32, height: 40))
        let title = sections[section]
        lblTitle.setUp(title: title.localized(), font: UIFont.Poppins.semiBold.size(FontSize.body_15), textColor: UIColor.AppColors.darkTextColor, noOfLine: 1)
        vwHeader.addSubview(lblTitle)
        return vwHeader
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withClass: NotificationListCell.self, for: indexPath)
        cell.selectionStyle = .none
        let notification = self.notifications?.notifications[indexPath.row]
        
//        for i in [notification] {
//        if self.notifications?.notifications[indexPath.row].isRead == true {
//            self.readNot = i
//
//        }else{
//            self.unreadNot = i
//        }
//        }
        
        if indexPath.section == 0 && notification?.isRead == false {
            
            cell.lblTitle.text = notification?.title
            cell.lblDesc.text = notification?.body
            cell.lblTime.text = notification?.createdAt?.toDate()?.toString(format: "hh:mm a")
            let url = notification?.data.imageUrl ?? "https://www.thecocktaildb.com/images/media/drink/3nbu4a1487603196.jpg"
            cell.imgVw.downloaded(from: url)
            
        } else if notification?.isRead == true {
            
            cell.lblTitle.text = notification?.title
            cell.lblDesc.text = notification?.body
            cell.lblTime.text = notification?.createdAt?.toDate()?.toString(format: "hh:mm a")
            let url = notification?.data.imageUrl ?? "https://www.thecocktaildb.com/images/media/drink/3nbu4a1487603196.jpg"
            cell.imgVw.downloaded(from: url)
            
//            cell.lblTitle.text = self.notifications?.notifications[indexPath.row + (self.notifications?.unreadCount ?? 0)].title
//            cell.lblDesc.text = self.notifications?.notifications[indexPath.row  + (self.notifications?.unreadCount ?? 0)].body
            
        }
        
        if indexPath.section == 0 && self.notifications?.unreadCount != 0{
            cell.backgroundColor = UIColor.AppColors.FCECFF
        } else {
            cell.backgroundColor = UIColor.AppColors.whiteTextColor
        }
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        _ = tableView.dequeueReusableCell(withClass: NotificationListCell.self, for: indexPath)
        let chatbot = AppStoryboard.topics.viewController(viewcontrollerClass: TopicsViewController.self)
        chatbot.hidesBottomBarWhenPushed = true
        chatbot.lessonsViewModel.lessonId = self.notifications?.notifications[indexPath.row].data.educationLessonId
        getNotifications()
        
        
        if self.notifications?.notifications[indexPath.row].isRead != true {
        notificationViewModel.putReadNotifications(notificationId: self.notifications?.notifications[indexPath.row].id ?? "", isRead: true) { isSuccess, error in
            if isSuccess {
                self.readNotificatins = self.notificationViewModel.readNotifications
                DispatchQueue.main.async {
                    self.getNotifications()
                }
            }
            else {
                print(error!)
            }
        }
        }
        
        self.navigationController?.pushViewController(chatbot, animated: true)
    }
    
}




extension Date {
    static func getFormattedDate(string: String , formatter:String) -> String{
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "hh:mm:ss a"
        
        let date: Date? = dateFormatterGet.date(from: "2018-02-01T19:10:04+00:00")
        print("Date",dateFormatterPrint.string(from: date!)) // Feb 01,2018
        return dateFormatterPrint.string(from: date!);
    }
}


extension UIImageView {
    func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
            else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    
    func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}
