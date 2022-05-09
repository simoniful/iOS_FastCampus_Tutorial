//
//  ViewController.swift
//  SpotifyLogin
//
//  Created by Sang hun Lee on 2022/05/09.
//

import UIKit

class LoginViewController: UIViewController {

    let loginView = LoginView()
    let API_KEY = Bundle.main.object(forInfoDictionaryKey: "API_KEY") as? String
    
    override func loadView() {
        self.view = loginView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        [loginView.emailButton, loginView.googleButton, loginView.appleButton].forEach {
//            $0.layer.borderWidth = 1
//            $0.layer.borderColor = UIColor.white.cgColor
//            $0.layer.cornerRadius = 30
//        }
        
        loginView.emailButton.addTarget(self, action: #selector(emailButtonTapped), for: .touchUpInside)
        loginView.googleButton.addTarget(self, action: #selector(googleButtonTapped), for: .touchUpInside)
        loginView.appleButton.addTarget(self, action: #selector(appleButtonTapped), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    @objc func emailButtonTapped() {
        let enterEmailViewController = EnterEmailViewController()
        self.navigationController?.pushViewController(enterEmailViewController, animated: true)
    }
    
    @objc func googleButtonTapped() {
        print("google")
    }
    
    @objc func appleButtonTapped() {
        print("apple")
    }
}

