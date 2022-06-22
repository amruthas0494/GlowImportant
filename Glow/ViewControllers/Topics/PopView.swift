//
//  PopView.swift
//  Glow
//
//  Created by apple on 22/02/22.
//  Copyright © 2022 CC. All rights reserved.
//

import UIKit
protocol CustomPopupViewDelegate: class
{
    func customPopupViewExtension(sender: PopView, didSelectNumber : Int)
}

class PopView: UIViewController {

    var titleString: String?
    var unitString: String?
    
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    
    
    @IBOutlet weak var unitLabel: UILabel!
    
    @IBOutlet weak var nextUnitButton: UIButton!
    
    
    @IBOutlet weak var dashBoardButton: UIButton!
    
    
    weak var delegate: CustomPopupViewDelegate?
       static func instantiate() -> PopView? {
           return PopView(nibName: nil, bundle: nil)
       }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        decorateUI()
       // titleLabel.text = titleString ?? ""
              
               nextUnitButton.addTarget(self, action: #selector(upNextButtonAction), for: .touchUpInside)
            dashBoardButton.addTarget(self, action: #selector(dashBoardButtonAction), for: .touchUpInside)
    }
    // MARK: - Private methods
       private func decorateUI() {
           
        self.titleLabel.setUp(title: "UpNext", font: UIFont.Poppins.regular.size(FontSize.body_13), textColor: UIColor.AppColors.darkTextColor, noOfLine: 0)
            self.unitLabel.setUp(title: "Unit 2 Keeping a lookout for foot issues", font: UIFont.Poppins.medium.size(FontSize.body_17), textColor: UIColor.AppColors.darkTextColor, noOfLine: 0)
        
           nextUnitButton.setUp(title: "Go to next unit", font: UIFont.Poppins.medium.size(FontSize.body_15), textColor: .white, bgColor: UIColor.AppColors.themeColor, radius: Constant.viewRadius4)
        dashBoardButton.setUp(title: "Go to Dashboard", font: UIFont.Poppins.medium.size(FontSize.body_15), textColor: UIColor.AppColors.themeColor, bgColor: .white, radius: Constant.viewRadius4)
           
           
       }
    @objc func upNextButtonAction() {
        delegate?.customPopupViewExtension(sender: self, didSelectNumber: 1)
    }
    
    @objc func dashBoardButtonAction() {
            let dashBoard = HomeViewController.instantiateFromAppStoryBoard(appStoryBoard: .home)
         
                 self.navigationController?.pushViewController(dashBoard, animated: true)
       }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
