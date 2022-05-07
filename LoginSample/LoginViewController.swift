//
//  LoginViewController.swift
//  LoginSample
//
//  Created by JUNO on 2022/05/06.
//

import UIKit
import Firebase
import GoogleSignIn

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailLoginBtn: UIButton!
    @IBOutlet weak var googleLoginBtn: GIDSignInButton!
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
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        let config = GIDConfiguration(clientID: clientID)
        
        GIDSignIn.sharedInstance.signIn(with: config, presenting: self) {
            user, error in
            
            if let error = error {
                return;
            }
            
            guard let auth = user?.authentication else { return }
            
            let credential = GoogleAuthProvider.credential(withIDToken: auth.idToken!, accessToken: auth.accessToken)
            
            Auth.auth().signIn(with: credential) { _, _ in
                self.ShowMainViewController()
            }
        }
    }
    
    private func ShowMainViewController() {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let mainViewController = storyboard.instantiateViewController(withIdentifier: "MainViewController")
        mainViewController.modalPresentationStyle = .fullScreen
        
        UIApplication.shared.windows.first?.rootViewController?.show(mainViewController, sender: nil)
    }
}
