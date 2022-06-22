//
//  CustomAlertViewController.swift
//  Glow
//
//  Created by Cognitiveclouds on 23/03/22.
//  Copyright © 2022 CC. All rights reserved.
//

import UIKit

class CustomAlertViewController: UIViewController {
    
    static let identifier = "CustomAlertViewController"
    
    @IBOutlet weak var viewContainer: UIView!
   
    @IBOutlet weak var errorImage: UIImageView!
    
    @IBOutlet weak var cancelImage: UIImageView!
    @IBOutlet weak var errorTitle: UILabel!
    
    
    @IBOutlet weak var errorDesc: UILabel!
    
    @IBOutlet weak var tryAgainBtn: UIButton!
    
    @IBOutlet weak var dimmedView: UIView!
    
    let maxDimmedAlpha: CGFloat = 0.6
    var message : String = ""
    
    @IBOutlet weak var cancelButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
      
        decorateUI()
        setupView()
        self.errorTitle.text = message
       //setupConstraints()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // animateShowDimmedView()
        animatePresentContainer()
        self.tabBarController?.tabBar.alpha = 0.6
        self.tabBarController?.tabBar.backgroundColor = .black
        self.navigationController?.navigationBar.isHidden = true
    }
    
    // MARK: - Private methods
    private func decorateUI() {
        
//        UIView.backgroundColor = .white
//        self.viewContainer.layer.cornerRadius = Constant.viewRadius16
//        self.viewContainer.clipsToBounds = true
//        self.viewContainer.layer.shadowColor = UIColor.black.cgColor
//        self.viewContainer.layer.shadowOpacity = 0.5
//        self.viewContainer.layer.shadowOffset = .zero
//        self.viewContainer.layer.shadowRadius = 5
//        viewContainer.backgroundColor = 
        viewContainer.layer.cornerRadius = Constant.viewRadius16
        viewContainer.layer.shadowColor = UIColor.gray.cgColor
        viewContainer.layer.shadowOffset = CGSize(width: 0, height: 1.5)
        viewContainer.layer.shadowOpacity = 0.5
        viewContainer.layer.shadowRadius = 5
        self.errorTitle.setUp(title: "Oops!Something went wrong", font: UIFont.Poppins.medium.size(FontSize.body_15), textColor: UIColor.AppColors.darkTextColor, noOfLine: 0)
      
        self.errorDesc.setUp(title: "We encountered an error here. Will you please try one more time? ", font: UIFont.Poppins.medium.size(FontSize.body_13), textColor: UIColor.AppColors.grayTextColor, noOfLine: 0)
        self.errorDesc.setUp(title: "We encountered an error here. Will you please try one more time? ", font: UIFont.Poppins.medium.size(FontSize.body_13), textColor: UIColor.AppColors.grayTextColor, noOfLine: 0)
       
        
        cancelButton.setUpBlank()
        
       errorImage.image = UIImage(named: "error.png")
        self.cancelImage.image = UIImage(named: "cancelblack")
        
        
        self.tryAgainBtn.setUp(title: "Try Again", font: UIFont.Poppins.medium.size(FontSize.body_17), textColor: UIColor.white, bgColor: UIColor.AppColors.errorMessage, radius: Constant.viewRadius4)
      
        
        dimmedView.backgroundColor = .black
        dimmedView.alpha = maxDimmedAlpha
        
    }
    
    func setupView() {
        view.backgroundColor = .clear
        //view.alpha = 0.9
    }
    
    func setupConstraints() {
        // 4. Add subviews
        view.addSubview(dimmedView)
        dimmedView.addSubview(viewContainer)
        dimmedView.translatesAutoresizingMaskIntoConstraints = false
        //containerView.translatesAutoresizingMaskIntoConstraints = false
        
        // 5. Set static constraints
        NSLayoutConstraint.activate([
            // set dimmedView edges to superview
            dimmedView.topAnchor.constraint(equalTo: view.topAnchor),
            dimmedView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            dimmedView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            dimmedView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            // set container static constraint (trailing & leading)
//            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
    func animatePresentContainer() {
        // Update bottom constraint in animation block
        UIView.animate(withDuration: 2.0) {
          //  self.containerViewBottomConstraint?.constant = 0
            // Call this to trigger refresh constraint
            self.view.layoutIfNeeded()
        }
    }
    @IBAction func tryAgainBtn_Tapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
        
       
    }
    
    @IBAction func cancelButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
}
