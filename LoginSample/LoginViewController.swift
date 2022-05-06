//
//  LoginViewController.swift
//  LoginSample
//
//  Created by JUNO on 2022/05/06.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailLoginBtn: UIButton!
    @IBOutlet weak var googleLoginBtn: UIButton!
    @IBOutlet weak var appleLoginBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        [emailLoginBtn,googleLoginBtn,appleLoginBtn].forEach{
            $0?.layer.borderWidth = 1
            $0?.layer.borderColor = UIColor.white.cgColor
            $0?.layer.cornerRadius = 30
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Navigation Bar 숨기기
        navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func tapAppleLogin(_ sender: UIButton) {
        // firebase 인증
    }
    
    @IBAction func tapGoogleLogin(_ sender: UIButton) {
        // firebase 인증
    }
    
    
}
