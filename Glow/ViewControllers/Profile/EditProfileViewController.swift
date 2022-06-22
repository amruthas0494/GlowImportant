//
//  EditProfileViewController.swift
//  Glow
//
//  Created by apple on 12/01/22.
//  Copyright © 2022 CC. All rights reserved.
//

import UIKit
import DropDown
import ProgressHUD

class EditProfileViewController: UIViewController, UITextFieldDelegate {
    
    static let identifier = "EditProfileViewController"
    
    // MARK: - Outlets
    @IBOutlet weak var firstNamelabel: UILabel!
    @IBOutlet weak var firstNametextField: UITextField!
    @IBOutlet weak var lastNamelabel: UILabel!
    @IBOutlet weak var lastNametxtField: UITextField!
    @IBOutlet weak var DOBlabel: UILabel!
    @IBOutlet weak var DOBtxtField: UITextField!
    @IBOutlet weak var Genderlabel: UILabel!
    @IBOutlet weak var GendertxtField: UITextField!
    @IBOutlet weak var genderButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    
    // MARK: - Variables
    let chooseGender = DropDown()
    var datePicker = UIDatePicker()
    var profileViewModel = ProfileViewModel()
    
    // MARK: - Page life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createDatePicker()
        setUpData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setTitle("Edit Profile".localized(), isBackButton: true)
        self.decorateUI()
    }
    
    // MARK: - UI Setup
    private func decorateUI() {
        
        [firstNamelabel, lastNamelabel, DOBlabel, Genderlabel].forEach { lbl in
            lbl?.setUp(title: "", font: UIFont.Poppins.medium.size(FontSize.body_13), textColor: UIColor.AppColors.grayTextColor, noOfLine: 1)
        }
        firstNamelabel.text = "First Name".localized()
        lastNamelabel.text = "Last Name".localized()
        DOBlabel.text = "DOB".localized()
        Genderlabel.text = "Gender".localized()
        
        [firstNametextField, lastNametxtField, DOBtxtField, GendertxtField].forEach { txt in
            txt?.font = UIFont.Poppins.regular.size(FontSize.body_15)
            txt?.layer.borderWidth = Constant.viewBorder1
            txt?.layer.borderColor = UIColor.AppColors.borderColor_D8E1E5.cgColor
            txt?.layer.cornerRadius = Constant.viewRadius4
            txt?.clipsToBounds = true
            txt?.textColor = UIColor.AppColors.darkTextColor
        }
        genderButton.setUpBlank()
        saveButton.setUp(title: "Save Changes".localized(), font: UIFont.Poppins.medium.size(FontSize.body_17), textColor: .white, bgColor: UIColor.AppColors.themeColor, radius: Constant.viewRadius4)
    }
    
    private func setUpData() {
        self.firstNametextField.text = Glow.sharedInstance.firstName
        self.lastNametxtField.text = Glow.sharedInstance.lastName
    }
    
    private func createDatePicker() {
        
        datePicker = UIDatePicker(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: Constant.datePickerHeight))
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        } else {
            // Fallback on earlier versions
        }
        datePicker.datePickerMode = .date
        self.DOBtxtField.inputView = datePicker
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        doneButton.tintColor = UIColor.AppColors.buttonImageColor
        let cancel = UIBarButtonItem(barButtonSystemItem: .cancel, target: nil, action: #selector(cancelAction))
        cancel.tintColor = UIColor.AppColors.buttonImageColor
        toolbar.setItems([doneButton, cancel], animated: true)
        self.DOBtxtField.inputAccessoryView = toolbar
    }
    
    @objc func cancelAction() {
        self.DOBtxtField.resignFirstResponder()
    }
    
    @objc func donePressed() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd, yyyy"
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        let dateString = dateFormatter.string(from: datePicker.date)
        self.DOBtxtField.text = dateString
        self.view.endEditing(true)
        self.DOBtxtField.resignFirstResponder()
    }
    
    @IBAction func chooseGender(_ sender: UIButton) {
        chooseGender.dataSource = ["Male".localized(), "Female".localized()]
        chooseGender.anchorView = sender
        chooseGender.bottomOffset = CGPoint(x: 0, y: sender.frame.size.height)
        chooseGender.show()
        chooseGender.selectionAction = { [weak self] (index: Int, item: String) in
            guard let _ = self else { return }
            self?.GendertxtField.text = item
        }
    }
    
    @IBAction func onBtnSubmitTap(sender: UIButton) {
        if let error = validateInput() {
            self.showErrorToast(error)
            return
        }
        ProgressHUD.show()
        profileViewModel.firstName = self.firstNametextField.text ?? ""
        profileViewModel.lastName = self.lastNametxtField.text ?? ""
        profileViewModel.dob = self.DOBtxtField.text ?? ""
        profileViewModel.gender = self.GendertxtField.text ?? ""
        profileViewModel.updateUserProfile { isSuccess, error in
            ProgressHUD.dismiss()
            DispatchQueue.main.async {
                if isSuccess {
                    self.showSuccessToast("Profile updated")
                    self.navigationController?.popViewController(animated: true)
                } else {
                   // self.showErrorToast(error)
                    self.alertMessage(title: error ?? "Oops!Something went wrong")
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
    
    // MARK: - Form validation
    private func validateInput() -> String? {
        if (self.firstNametextField.text ?? "").trimWhiteSpace.isEmpty {
            return "Please enter first name"
        } else if (self.lastNametxtField.text ?? "").trimWhiteSpace.isEmpty {
            return "Please enter last name"
        } else if (self.DOBtxtField.text ?? "").trimWhiteSpace.isEmpty {
            return "Please select date of birth"
        } else if (self.GendertxtField.text ?? "").trimWhiteSpace.isEmpty {
            return "Please select gender"
        }
        return nil
    }
}


