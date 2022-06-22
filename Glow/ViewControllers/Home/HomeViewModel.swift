//
//  HomeViewModel.swift
//  Glow
//
//  Created by Nidhishree HP on 21/12/21.
//  Copyright © 2021 CC. All rights reserved.
//

class HomeViewModel: NSObject {
    
//    let arrTiles: [(id: Int, image: String, color: UIColor, title: String, subTitle: String)] = [
//        (1, "cloud-lightning", UIColor.AppColors.blue72B8FF, "Dr. Daniel Recommends you to Read", "4 topics"),
//        (2, "continueLearning", UIColor.AppColors.redFF7976, "Continue Learning", "2 topics"),
//        (3, "archive", UIColor.AppColors.purple7C83FF, "Recommended Learning Bites", "15 topics"),
//        (4, "check-circle", UIColor.AppColors.orangeFFAB5C, "Already Completed", "4 topics")]
    
    let arrTiles: [(id: Int, image: String, color: UIColor, title: String)] = [
        (1, "archive", UIColor.AppColors.blue72B8FF, "Recommended Learning Bites"),
        (2, "continueLearning", UIColor.AppColors.redFF7976, "Continue Learning"),
        (3, "check-circle", UIColor.AppColors.orangeFFAB5C, "Already Completed")]
}
