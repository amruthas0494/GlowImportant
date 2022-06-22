//
//  TypingCell.swift
//  Glow
//
//  Created by Pushpa Yadav on 22/11/21.
//  Copyright © 2021 CC. All rights reserved.
//

import UIKit
import Lottie

class TypingCell: UITableViewCell {
    
    static let identifier = "TypingCell"
    
    // MARK: - Outlet
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var vwContainer: UIView!
    @IBOutlet weak var vwAnimation: UIView!
    
    // MARK: - Variable
    private var animationView: AnimationView?

    // MARK: - awakeFromNib
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.vwContainer.backgroundColor = UIColor.AppColors.navigationBackground
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        DispatchQueue.main.async {
            let path = UIBezierPath(roundedRect: self.vwContainer.bounds, byRoundingCorners: [.topRight, .bottomLeft, .bottomRight], cornerRadii: CGSize(width: Constant.viewRadius8, height: Constant.viewRadius8))
            let mask = CAShapeLayer()
            mask.path = path.cgPath
            self.vwContainer.layer.mask = mask
            
            self.imgView.layer.cornerRadius = self.imgView.frame.width/2
            self.imgView.clipsToBounds = true
        }
    }
    
    func startAnimation() {
        
        if let animationVw = self.vwAnimation.viewWithTag(100) {
            animationVw.removeFromSuperview()
        }
        animationView = .init(name: "10357-chat-typing-indicator")
        animationView!.frame = self.vwAnimation.bounds
        animationView!.contentMode = .scaleAspectFill
        animationView!.loopMode = .loop
        animationView!.animationSpeed = 0.5
        animationView!.tag = 100
        vwAnimation.addSubview(animationView!)
        animationView!.play()
    }
}
