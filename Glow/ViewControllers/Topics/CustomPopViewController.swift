//
//  CustomPopViewController.swift
//  Glow
//
//  Created by apple on 23/02/22.
//  Copyright © 2022 CC. All rights reserved.
//

import UIKit

class CustomPopViewController: UIViewController {
   // 1
       lazy var containerView: UIView = {
           let view = UIView()
           view.backgroundColor = .white
        view.layer.cornerRadius = Constant.viewRadius16
           view.clipsToBounds = true
           return view
       }()
       
       // 2
       let maxDimmedAlpha: CGFloat = 0.6
       lazy var dimmedView: UIView = {
           let view = UIView()
           view.backgroundColor = .black
           view.alpha = maxDimmedAlpha
           return view
       }()
       
    lazy var titleLabel: UILabel = {
           let label = UILabel()
       label.setUp(title: "UpNext", font: UIFont.Poppins.regular.size(FontSize.body_13), textColor: UIColor.AppColors.darkTextColor, noOfLine: 0)
        label.textAlignment = .center
           return label
       }()
    lazy var unitLabel: UILabel = {
           let label = UILabel()
           label.setUp(title: "Unit 2 Keeping a lookout for foot issues", font: UIFont.Poppins.medium.size(FontSize.body_17), textColor: UIColor.AppColors.darkTextColor, noOfLine: 0)
        label.textAlignment = .center
           return label
       }()
    
    lazy var gotoNext: UIButton = {
        let button = UIButton()
        button.setUp(title: "Go to next unit", font: UIFont.Poppins.medium.size(FontSize.body_15), textColor: .white, bgColor: UIColor.AppColors.themeColor, radius: Constant.viewRadius4)
        button.isUserInteractionEnabled = true
              button.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        return button
    }()
    lazy var gotodasboard: UIButton = {
        let button = UIButton()
        button.setUp(title: "Go to Dashboard", font: UIFont.Poppins.medium.size(FontSize.body_15), textColor: UIColor.AppColors.themeColor, bgColor: .white, radius: Constant.viewRadius4)
         button.isUserInteractionEnabled = true
        return button
    }()
    
    var popdelegate: navigationDelegate?
   
       let defaultHeight: CGFloat = 300
       
       // 3. Dynamic container constraint
       var containerViewHeightConstraint: NSLayoutConstraint?
       var containerViewBottomConstraint: NSLayoutConstraint?
    var containerViewTopConstraint: NSLayoutConstraint?
       
    lazy var containerStackView: UIStackView = {
        let spacer = UIView()
        let stackView = UIStackView(arrangedSubviews: [ spacer, titleLabel, unitLabel, gotoNext, gotodasboard ])
        stackView.axis = .vertical
        stackView.spacing = Constant.containerstackSpace
        return stackView
    }()
   
    
       override func viewDidLoad() {
           super.viewDidLoad()
        
           setupView()
           setupConstraints()
        // decorateUI()
        
        gotodasboard.addTarget(self, action: #selector(dashboardButtonTapped), for: .touchUpInside)
       
        
       }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
       // animateShowDimmedView()
        animatePresentContainer()
    }

    
       // MARK: - Private methods
         private func decorateUI() {
//             titleLabel.setUp(title: "UpNext", font: UIFont.Poppins.regular.size(FontSize.body_13), textColor: UIColor.AppColors.darkTextColor, noOfLine: 0)
//            titleLabel.textAlignment = .center
//                unitLabel.setUp(title: "Unit 2 Keeping a lookout for foot issues", font: UIFont.Poppins.medium.size(FontSize.body_17), textColor: UIColor.AppColors.darkTextColor, noOfLine: 0)
//             unitLabel.textAlignment = .center
//                gotoNext.setUp(title: "Go to next unit", font: UIFont.Poppins.medium.size(FontSize.body_15), textColor: .white, bgColor: UIColor.AppColors.themeColor, radius: Constant.viewRadius4)
//             gotodasboard.setUp(title: "Go to Dashboard", font: UIFont.Poppins.medium.size(FontSize.body_15), textColor: UIColor.AppColors.themeColor, bgColor: .white, radius: Constant.viewRadius4)
            
            
                
         }
       func setupView() {
           view.backgroundColor = .clear
       }
       
       func setupConstraints() {
           // 4. Add subviews
           view.addSubview(dimmedView)
           view.addSubview(containerView)
           dimmedView.translatesAutoresizingMaskIntoConstraints = false
           containerView.translatesAutoresizingMaskIntoConstraints = false
           
           // 5. Set static constraints
           NSLayoutConstraint.activate([
               // set dimmedView edges to superview
               dimmedView.topAnchor.constraint(equalTo: view.topAnchor),
               dimmedView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
               dimmedView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
               dimmedView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
               // set container static constraint (trailing & leading)
               containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
               containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
           ])
           
           // 6. Set container to default height
           containerViewHeightConstraint = containerView.heightAnchor.constraint(equalToConstant: defaultHeight)
           // 7. Set bottom constant to 0
           containerViewBottomConstraint = containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
         containerViewTopConstraint = containerView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0)
           // Activate constraints
           containerViewHeightConstraint?.isActive = true
           containerViewBottomConstraint?.isActive = true
        /*
        containerView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        let safeArea = containerView.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
                   // 6. Set containerStackView edges to superview with 24 spacing
            titleLabel.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: Constant.TlabelTop),
                  // titleLabel.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: Constant.TLabelBottom),
                   titleLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: Constant.Tlabelleading),
                   titleLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: Constant.Tlabeltrailing),
                   // 7. Set button height
                  // registerButton.heightAnchor.constraint(equalToConstant: 50)
               ])
        containerView.addSubview(unitLabel)
        unitLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
                          // 6. Set containerStackView edges to superview with 24 spacing
                   unitLabel.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: Constant.UlabelTop),
                         // unitLabel.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: Constant.ULabelBottom),
                          unitLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: Constant.Ulabelleading),
                          unitLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: Constant.Ulabeltrailing),
                          // 7. Set button height
                         // registerButton.heightAnchor.constraint(equalToConstant: 50)
                      ])
        
        
        
        
        containerView.addSubview(gotoNext)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
               // 6. Set containerStackView edges to superview with 24 spacing
        gotoNext.topAnchor.constraint(equalTo: unitLabel.bottomAnchor, constant: Constant.nextButtontop),
            //   gotoNext.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: Constant.nextButtonBottom),
               gotoNext.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: Constant.nextButtonleading),
               gotoNext.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: Constant.nextButtontrailing),
               // 7. Set button height
            gotoNext.heightAnchor.constraint(equalToConstant: Constant.buttonHeight)
           ])
        
        
        containerView.addSubview(gotodasboard)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
               // 6. Set containerStackView edges to superview with 24 spacing
        gotodasboard.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: Constant.dashButtontop),
              // gotodasboard.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: Constant.dashButtonbottom),
               gotodasboard.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: Constant.dashButtonleading),
               gotodasboard.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: Constant.dashButtontrailing),
               // 7. Set button height
            gotodasboard.heightAnchor.constraint(equalToConstant: Constant.buttonHeight)
           ])
        
        */
        containerView.addSubview(containerStackView)
               containerStackView.translatesAutoresizingMaskIntoConstraints = false
               
               let safeArea = view.safeAreaLayoutGuide
               // 5. Call .activate method to enable the defined constraints
               NSLayoutConstraint.activate([
                   // 6. Set containerStackView edges to superview with 24 spacing
                containerStackView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: Constant.containerstackTop),
                containerStackView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: Constant.containerstackbottom),
                containerStackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: Constant.containerstackleading),
                containerStackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: Constant.containerstacktrailing),
                   // 7. Set button height
                gotoNext.heightAnchor.constraint(equalToConstant: Constant.buttonHeight),
                gotodasboard.heightAnchor.constraint(equalToConstant: Constant.buttonHeight),
                 
               ])
        
       }
    func animatePresentContainer() {
        // Update bottom constraint in animation block
        UIView.animate(withDuration: 2.0) {
            self.containerViewBottomConstraint?.constant = 0
            // Call this to trigger refresh constraint
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func nextButtonTapped()  {
       let moduleVC = ModuleSummaryViewController.instantiateFromAppStoryBoard(appStoryBoard: .moduleSummary)
       let navController = UINavigationController(rootViewController: moduleVC)
         navController.modalPresentationStyle = .fullScreen
              moduleVC.modalPresentationStyle = .fullScreen
        moduleVC.modalTransitionStyle = .coverVertical
       self.present(navController, animated: true, completion: nil)
       
    }
    @objc func dashboardButtonTapped()  {
            let dashBoard = HomeTabBarController.instantiateFromAppStoryBoard(appStoryBoard: .hometab)
         
        dashBoard.modalPresentationStyle = .fullScreen
         dashBoard.hidesBottomBarWhenPushed = false
         //dashBoard.tabBarController?.tabBar.isHidden = false
               //dashBoard.modalTransitionStyle = .flipHorizontal

        present(dashBoard, animated: true, completion: nil)
      }
    
 }

