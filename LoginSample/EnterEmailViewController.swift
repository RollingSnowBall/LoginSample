//
//  EnterEmailViewController.swift
//  LoginSample
//
//  Created by JUNO on 2022/05/06.
//

import UIKit
import FirebaseAuth

class EnterEmailViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var pwdTextField: UITextField!
    @IBOutlet weak var errorMsgLabel: UILabel!
    
    @IBOutlet weak var nextBtn: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //Navigation Bar 설정
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .black
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        //Navigation Bar 보이기
        navigationController?.navigationBar.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nextBtn.layer.cornerRadius = 30
        nextBtn.isEnabled = false
        
        emailTextField.delegate = self
        pwdTextField.delegate = self
        
        emailTextField.becomeFirstResponder()
    }
    
    @IBAction func tapNextBtn(_ sender: UIButton) {
        //Firebase 이메일/비밀번호 인증
        let email = emailTextField.text ?? ""
        let pwd = pwdTextField.text ?? ""
        
        //신규 사용자 생성
        Auth.auth().createUser(withEmail: email, password: pwd){
            [weak self] authResult, error in
            guard let self = self else { return }
            
            if let error = error {
                let code = (error as NSError).code
                
                switch code{
                case 17007: //이미 가입한 계정일 때
                    self.loginUser(withEmail: email, password: pwd)
                default:
                    self.errorMsgLabel.text = error.localizedDescription
                }
            }else{
                self.showMainViewController()
            }
        }
    }
    
    private func showMainViewController(){
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let mainViewController = storyboard.instantiateViewController(withIdentifier: "MainViewController")
        mainViewController.modalPresentationStyle = .fullScreen
        navigationController?.show(mainViewController, sender: nil)
    }
    
    private func loginUser(withEmail email: String, password: String){
        Auth.auth().signIn(withEmail: email, password: password){
            [weak self] _, error in
            guard let self = self else { return }
            
            if let error = error {
                self.errorMsgLabel.text = error.localizedDescription
            }else{
                self.showMainViewController()
            }
        }
    }
    
}

extension EnterEmailViewController : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        let isEmailEmpty = emailTextField.text == ""
        let isPwdEmpty = pwdTextField.text == ""
        
        nextBtn.isEnabled = !isEmailEmpty && !isPwdEmpty
    }
}
