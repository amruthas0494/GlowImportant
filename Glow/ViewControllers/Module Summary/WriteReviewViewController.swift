//
//  WriteReviewViewController.swift
//  Glow
//
//  Created by apple on 17/12/21.
//  Copyright © 2021 CC. All rights reserved.
//

import UIKit
import Cosmos

class WriteReviewViewController: UIViewController, NSTextStorageDelegate {
    
    static let identifier = "WriteaReviewController"
    
    // MARK: - Outlets
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblSubTitle: UILabel!
    @IBOutlet weak var vwRating: CosmosView!
    @IBOutlet weak var txtVwReview: UITextView!
    @IBOutlet weak var lblSuggestion: UILabel!
    @IBOutlet weak var txtVwSuggestion: UITextView!
    @IBOutlet weak var btnSubmit: UIButton!
    @IBOutlet weak var btnSkip: UIButton!
    
    // MARK: - Variables
    var reviewViewModel = LessonReviewViewModel()
    
    // MARK: - Page life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        decorateUI()
        vwRating.didFinishTouchingCosmos = { rating in }
        vwRating.didTouchCosmos = { rating in }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setTitle("Write a Review".localized(), isBackButton: true)
    }
    
    // MARK: - Private methods
    private func decorateUI() {
        
        lblTitle.setUp(title: "Write a Review".localized(), font: UIFont.Poppins.medium.size(FontSize.body_17), textColor: UIColor.AppColors.themeColor, noOfLine: 0)
        lblSubTitle.setUp(title: "Share what you think about this module with other users".localized(), font: UIFont.Poppins.medium.size(FontSize.body_15), textColor: UIColor.AppColors.darkTextColor, noOfLine: 0)
        lblSuggestion.setUp(title: "Any suggestions for the creators of the app?".localized(), font: UIFont.Poppins.medium.size(FontSize.body_15), textColor: UIColor.AppColors.darkTextColor, noOfLine: 0)
        
        [txtVwReview, txtVwSuggestion].forEach { txtVw in
            
            txtVw?.textColor = UIColor.AppColors.gray3
            txtVw?.font = UIFont.Poppins.regular.size(FontSize.body_15)
            txtVw?.textContainerInset = UIEdgeInsets(top: Constant.txtVwEdge, left: Constant.txtVwEdge, bottom: Constant.txtVwEdge, right: Constant.txtVwEdge)
            txtVw?.layer.cornerRadius = Constant.viewRadius4
            txtVw?.layer.borderWidth = Constant.viewBorder1
            txtVw?.layer.borderColor = UIColor.AppColors.greenBorder.cgColor
            txtVw?.clipsToBounds = true
            txtVw?.placeholder = "Write down your thoughts."
            txtVw?.textColor = .AppColors.gray3
            txtVw?.delegate = self
            txtVw?.leftSpace()
           // txtVw?.textStorage.delegate = self
        }
       
        
        btnSubmit.setUp(title: "Submit".localized(), font: UIFont.Poppins.medium.size(FontSize.body_17), textColor: .white, bgColor: UIColor.AppColors.themeColor, radius: Constant.viewRadius4)
        btnSkip.setUp(title: "Skip".localized(), font: UIFont.Poppins.medium.size(FontSize.body_17), textColor: UIColor.AppColors.themeColor, bgColor: UIColor.AppColors.whiteTextColor)
        
        vwRating.rating = 0.0
        vwRating.settings.updateOnTouch = true
        vwRating.settings.fillMode = .full
        vwRating.settings.starSize = Double(Constant.starSize)
        vwRating.settings.starMargin = Double(Constant.starMargin)
        vwRating.settings.filledColor = UIColor.systemYellow
        vwRating.settings.emptyColor = UIColor.white
        vwRating.settings.emptyBorderColor = UIColor.darkGray
        vwRating.settings.filledBorderColor = UIColor.systemYellow
    }
    
    private func moveToNext() {
        let moduleSummaryVC = ModuleSummaryViewController.instantiateFromAppStoryBoard(appStoryBoard: AppStoryboard.moduleSummary)
        moduleSummaryVC.lessonReviewVM.lessonId = reviewViewModel.lessonId
        self.navigationController?.pushViewController(moduleSummaryVC, animated: true)
    }
    
    // MARK: - API Call
    private func saveReview(review: String, suggestion:String) {
        
        ProgressHUD.show()
        reviewViewModel.rating = Int(vwRating.rating)
        reviewViewModel.review = review
        reviewViewModel.suggestion = suggestion
        reviewViewModel.addReview { [weak self] (isSuccess, error) in
            ProgressHUD.dismiss()
            DispatchQueue.main.async {
                self?.txtVwReview.text = nil
                self?.txtVwSuggestion.text = nil
                self?.vwRating.rating = 0.0
                if isSuccess {
                    self?.showSuccessToast("Added a Review")
                    self?.moveToNext()
                } else {
                    self?.showErrorToast(error ?? "Already reviewd")
                   // self?.alertMessage(title: error ?? "Oops!Something went wrong")
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
    
    // MARK: - IBActions
    @IBAction func onBtnSubmitTap(sender: UIButton) {
        guard let review = self.txtVwReview.text, !review.trimWhiteSpace.isEmpty  else {
            self.showErrorToast("Please enter review")
            return
        }
        guard let suggestion = self.txtVwSuggestion.text, !suggestion.trimWhiteSpace.isEmpty else {
            self.showErrorToast("Please enter suggestion")
            return
        }
        saveReview(review: review, suggestion: suggestion)
    }
    
    @IBAction func onBtnSkipTap(sender: UIButton) {
        moveToNext()
    }
}


extension WriteReviewViewController : UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.AppColors.lightGray {
            textView.text = ""
            textView.textColor = UIColor.black
            textView.becomeFirstResponder()
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Write down your thoughts.".localized()
            textView.textColor = UIColor.AppColors.lightGray
        }
    }
}
