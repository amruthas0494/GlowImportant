//
//  BiometricViewController.swift
//  Glow
//
//  Created by apple on 28/12/21.
//  Copyright © 2021 CC. All rights reserved.
//

import UIKit

class BiometricViewController: UIViewController {
    
    static let identifier = "BiometricViewController"
    
    // MARK: - Outlets
    @IBOutlet weak var btnLock: UIButton!
    
    // MARK: - Variables
    let objAuthentication = BiometricIDAuth()
    var authType: String?
    
    // MARK: - Page life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        authType = UserDefaults.lockScreen
        setUpLockScreen()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    // MARK: - Private method
    private func setUpLockScreen() {
        let biometric = objAuthentication.biometricType()
        switch biometric {
        case .none:
            print("none-----")
        case .touchID:
            btnLock.setUpBlank()
            btnLock.setImage(UIImage(named: "fingerprint"), for: .normal)
        case .faceID:
            btnLock.setUpBlank()
            btnLock.setImage(UIImage(named: "faceIdentification"), for: .normal)
        @unknown default:
            print("unknown-----")
        }
    }
    
    // MARK: - Actions
    @IBAction func onBtnAuthTap(sender: UIButton) {
        objAuthentication.authenticateUser {[weak self] message in
            DispatchQueue.main.async{
                if let message = message {
                    let alertView = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
                    alertView.addAction(UIAlertAction(title: "OK", style: .default))
                    self?.present(alertView, animated: true)
                } else {
                    self?.dismiss(animated: true, completion: nil)
                }
            }
        }
    }
}
