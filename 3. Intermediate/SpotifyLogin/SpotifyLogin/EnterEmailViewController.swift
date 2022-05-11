//
//  EnterEmailViewController.swift
//  SpotifyLogin
//
//  Created by Sang hun Lee on 2022/05/09.
//

import UIKit
import Firebase
import FirebaseAuth

class EnterEmailViewController: UIViewController {

    let enterEmailView = EnterEmailView()
    
    override func loadView() {
        self.view = enterEmailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "이메일/비밀번호 입력하기"
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        enterEmailView.nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        
        enterEmailView.emailTextField.delegate = self
        enterEmailView.passwordTextField.delegate = self
        
        enterEmailView.emailTextField.becomeFirstResponder()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    
    @objc func nextButtonTapped() {
        // Firebase 이메일 / 비밀번호 인증
        let email = enterEmailView.emailTextField.text ?? ""
        let password = enterEmailView.passwordTextField.text ?? ""
        // 신규 사용자 생성
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] authResult, error in
            guard let self = self else { return }
            
            if let error = error {
                let code = (error as NSError).code
                switch code {
                case 17007:
                    self.loginUser(withEmail: email, password: password)
                default:
                    self.enterEmailView.errorLabel.text = error.localizedDescription
                }
            } else {
                self.showMainViewController()
            }
        }
    }
    
    private func loginUser(withEmail email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] _, error in
            guard let self = self else { return }
            if let error = error {
                self.enterEmailView.errorLabel.text = error.localizedDescription
            } else {
                self.showMainViewController()
            }
        }
    }
    
    private func showMainViewController() {
        let mainViewController = MainViewController()
        mainViewController.modalPresentationStyle = .fullScreen
        navigationController?.show(mainViewController, sender: nil)
    }
}

extension EnterEmailViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        let isEmailEmpty = enterEmailView.emailTextField.text == ""
        let isPasswordEmpty = enterEmailView.passwordTextField.text == ""
        enterEmailView.nextButton.isEnabled = !isEmailEmpty && !isPasswordEmpty
    }
}
