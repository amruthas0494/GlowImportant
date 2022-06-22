//
//  AuthCoordinator.swift
//  Glow
//
//  Created by Cognitiveclouds2021_4 on 31/12/21.
//  Copyright © 2021 CC. All rights reserved.
//

import Foundation
import UIKit

protocol AuthCoordinatorDelegate: AnyObject {
    func didAuthenticate(coordinator: AuthCoordinator)
}

class AuthCoordinator: Coordinator {
    
    var childCoordinator: [Coordinator] = []
    
    var navigationController: UINavigationController
    
    weak var delegate: AuthCoordinatorDelegate?
    
    init(navController: UINavigationController) {
        navigationController = navController
    }
    
    func configureRootViewController() {
        
    }
    
    
}
