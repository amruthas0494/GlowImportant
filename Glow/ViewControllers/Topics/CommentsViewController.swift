//
//  CommentsViewController.swift
//  Glow
//
//  Created by Pushpa Yadav on 22/12/21.
//  Copyright © 2021 CC. All rights reserved.
//

import UIKit

class CommentsViewController: UIViewController {
    
    static let identifier = "CommentsViewController"
    
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var vwComment: UIView!
    @IBOutlet weak var txtComment: UITextField!
    @IBOutlet weak var btnSend: UIButton!
    
    @IBOutlet weak var NoCommentLabel: UILabel!
    // MARK: - Variables
    var objCommentViewModel = CommentViewModel()
    
    // MARK: - Page life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
        
        decorateUI()
        getComments()
        //sendComment(comment: <#T##String#>)
    }
    
    // MARK: - Private methods
    private func decorateUI() {
        NoCommentLabel.setUp(title: "Be the first one to add comment", font: UIFont.Poppins.semiBold.size(FontSize.body_17), textColor: UIColor.AppColors.blackText, noOfLine: 0)
        NoCommentLabel.isHidden = true
        self.btnSend.setUpBlank()
        self.btnSend.setImage(UIImage(named: "sendComment"), for: .normal)
        
        self.vwComment.layer.cornerRadius = Constant.viewRadius4
        self.vwComment.layer.borderWidth = Constant.viewBorder1
        self.vwComment.layer.borderColor = UIColor.AppColors.borderColor_D8E1E5.cgColor
        self.vwComment.clipsToBounds = true
        
        self.txtComment.placeholder = "Comment here..."
        self.txtComment.font = UIFont.Poppins.regular.size(FontSize.body_13)
    }
    
    private func getComments() {
        ProgressHUD.show()
        objCommentViewModel.getAllComments { isSuccess, errMessage in
            ProgressHUD.dismiss()
            DispatchQueue.main.async {
                if isSuccess {
                    self.tableView.reloadData()
                } else {
                    //self.showErrorToast(errMessage)
                    self.alertMessage(title: errMessage ?? "Oops!Something went wrong")
                }
                if ((self.objCommentViewModel.arrComments?.isEmpty) != nil) {
                    self.NoCommentLabel.isHidden = false
                }
                else {
                    self.NoCommentLabel.isHidden = true
                   
                }
            }
        }
    }
    
    private func sendComment(comment: String) {
        ProgressHUD.show()
        objCommentViewModel.comment = comment
        objCommentViewModel.saveComment { isSuccess, errMessage in
            ProgressHUD.dismiss()
            DispatchQueue.main.async {
                if isSuccess {
                    self.txtComment.text = nil
                    self.tableView.reloadData()
                }
                
                
                if (errMessage != nil) {
                    self.alertMessage(title: errMessage ?? "Oops!Something went wrong")
                }
            }
        }
    }
    
    // MARK: - IBActions
    @IBAction func onBtnSendComment(sender: UIButton) {
        
        guard let comment = self.txtComment.text, !comment.trimWhiteSpace.isEmpty else {
            return
        }
        sendComment(comment: comment)
    }
    
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension CommentsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.objCommentViewModel.arrComments?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withClass: CommentsCell.self, for: indexPath)
        cell.selectionStyle = .none
        let object = self.objCommentViewModel.arrComments?[indexPath.row]
        cell.objComment = object
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let cell = cell as? CommentsCell {
            cell.imgUser.layer.cornerRadius = cell.imgUser.bounds.height/2
            cell.imgUser.clipsToBounds = true
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
