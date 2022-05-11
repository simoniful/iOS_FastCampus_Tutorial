//
//  MainViewController.swift
//  SpotifyLogin
//
//  Created by Sang hun Lee on 2022/05/10.
//

import UIKit
import FirebaseAuth

class MainViewController: UIViewController {
    let mainView = MainView()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        mainView.logoutButton.addTarget(self, action: #selector(logoutButtonTapped), for: .touchUpInside)
        mainView.passwordChangeButton.addTarget(self, action: #selector(passwordChangeButtonTapped), for: .touchUpInside)
        mainView.profileUpdateButton.addTarget(self, action: #selector(profileUpdateButtonTapped), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let email = Auth.auth().currentUser?.email ?? "고객"
        
        mainView.welcomeLabel.text = """
        환영합니다.
        \(email)님
        """
        navigationController?.navigationBar.isHidden = true
        let isEmailSignIn = Auth.auth().currentUser?.providerData[0].providerID == "password"
        mainView.passwordChangeButton.isHidden = !isEmailSignIn
    }
    
    @objc func logoutButtonTapped() {
        let firebaseAuth = Auth.auth()
        
        do {
            try firebaseAuth.signOut()
            self.navigationController?.popToRootViewController(animated: true)
        } catch let signOutError as NSError {
            print("Error: signOut \(signOutError.localizedDescription)")
        }
    }
    
    @objc func passwordChangeButtonTapped() {
        let email = Auth.auth().currentUser?.email ?? ""
        Auth.auth().sendPasswordReset(withEmail: email, completion: nil)
    }
    
    @objc func profileUpdateButtonTapped() {
        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
        // photoURL,displayName 둘 다 변경 가능
        changeRequest?.displayName = "Simon"
        changeRequest?.commitChanges{ [weak self] _ in
            guard let self = self else { return }
            let displayName = Auth.auth().currentUser?.displayName ?? Auth.auth().currentUser?.email ?? "고객"
            
            self.mainView.welcomeLabel.text = """
            환영합니다.
            \(displayName)님
            """
        }
    }
}
