//
//  EnterEmailViewController.swift
//  SpotifyLogin
//
//  Created by Sang hun Lee on 2022/05/09.
//

import UIKit

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
        print("nextButton")
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
