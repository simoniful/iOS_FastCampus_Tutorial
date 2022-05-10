//
//  MainViewController.swift
//  SpotifyLogin
//
//  Created by Sang hun Lee on 2022/05/10.
//

import UIKit

class MainViewController: UIViewController {
    let mainView = MainView()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        mainView.logoutButton.addTarget(self, action: #selector(logoutButtonTapped), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    @objc func logoutButtonTapped() {
        print("logout button tapped!")
        self.navigationController?.popToRootViewController(animated: true)
    }
    
}
