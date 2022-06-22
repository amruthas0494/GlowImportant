//
//  CreateAccountCell.swift
//  Glow
//
//  Created by Pushpa Yadav on 24/11/21.
//  Copyright © 2021 CC. All rights reserved.
//

import UIKit

class CreateAccountCell: UITableViewCell {
    
    static let identifier = "CreateAccountCell"
    
    // MARK: - Outlet
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var txtUserName: UITextField!
    @IBOutlet weak var lblPassword: UILabel!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var cvPassword: UICollectionView!
    @IBOutlet weak var lblStrength: UILabel!
    @IBOutlet weak var lblRepeatPassword: UILabel!
    @IBOutlet weak var txtRepeatPassword: UITextField!
    @IBOutlet weak var vwSubmit: UIView!
    @IBOutlet weak var lblSubmit: UILabel!
    @IBOutlet weak var btnSubmit: UIButton!
    
    // MARK: - Variables
    var passwordStrength: Int = -1 {
        didSet {
            cvPassword.reloadData()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
        cvPassword.delegate = self
        cvPassword.dataSource = self
        cvPassword.register(PasswordStrengthCell.self, forCellWithReuseIdentifier: "PasswordStrengthCell")
        
        lblStrength.setUp(title: "Strong".Chatbotlocalized(), font: UIFont.Poppins.regular.size(FontSize.body_13), textColor: UIColor.AppColors.grayTextColor, noOfLine: 0)
        
        [lblUserName, lblPassword, lblRepeatPassword].forEach { lbl in
            lbl?.setUp(title: "", font: UIFont.Poppins.medium.size(FontSize.body_13), textColor: UIColor.AppColors.grayTextColor, noOfLine: 0)
        }
        lblUserName.text = "Email".Chatbotlocalized()
        lblPassword.text = "Password".Chatbotlocalized()
        lblRepeatPassword.text = "Repeat Password".Chatbotlocalized()
        [txtUserName, txtPassword, txtRepeatPassword].forEach { txt in
            txt?.backgroundColor = UIColor.AppColors.navigationBackground
            txt?.font = UIFont.Poppins.semiBold.size(FontSize.body_15)
        }
       
        
        txtPassword.isSecureTextEntry = true
        txtRepeatPassword.isSecureTextEntry = true
        
        txtPassword.delegate = self
        
        vwSubmit.backgroundColor = UIColor.AppColors.themeColor
        vwSubmit.layer.cornerRadius = Constant.buttonRadius
        vwSubmit.clipsToBounds = true
        
        lblSubmit.setUp(title: "Submit".Chatbotlocalized(), font: UIFont.Poppins.medium.size(FontSize.body_17), textColor: .white, noOfLine: 1)
        btnSubmit.setUpBlank()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        lblStrength.font = UIFont.Poppins.regular.size(FontSize.body_13)
        [lblUserName, lblPassword, lblRepeatPassword].forEach { lbl in
            lbl?.font = UIFont.Poppins.medium.size(FontSize.body_13)
        }
        [txtUserName, txtPassword, txtRepeatPassword].forEach { txt in
            txt?.font = UIFont.Poppins.semiBold.size(FontSize.body_15)
        }
        lblSubmit.font = UIFont.Poppins.medium.size(FontSize.body_17)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    private func isValidatedPassword(_ password: String) {
        
        self.passwordStrength = -1
        if password.leastOneLowerCase {
            self.passwordStrength += 1
        }
        if password.leastOneUpperCase {
            self.passwordStrength += 1
        }
        if password.leastOneDigit {
            self.passwordStrength += 1
        }
        if password.leastOneSpecialCharacter {
            self.passwordStrength += 1
        }
        if password.leastEightCharacter {
            self.passwordStrength += 1
        }
    }
    
}

// MARK: - UICollectionViewDelegateFlowLayout, UICollectionViewDataSource
extension CreateAccountCell: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let sizeMultiplayar = UIDevice.current.userInterfaceIdiom == .phone ? 1 : 2
        return CGSize(width: 20*sizeMultiplayar, height: 4*sizeMultiplayar)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PasswordStrengthCell", for: indexPath)
        cell.contentView.layer.cornerRadius = cell.frame.height/2
        cell.contentView.clipsToBounds = true
        cell.contentView.backgroundColor = (self.passwordStrength) >= (indexPath.row) ? .systemGreen : UIColor.AppColors.borderColor
        return cell
    }
}


// MARK: - UITextFieldDelegate
extension CreateAccountCell: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let text = textField.text,
           let textRange = Range(range, in: text) {
            let updatedText = text.replacingCharacters(in: textRange, with: string)
            self.isValidatedPassword(updatedText)
        }
        return true
    }
}
