//
//  AppViewController.swift
//  AppStore
//
//  Created by Sang hun Lee on 2022/05/23.
//

import UIKit
import SnapKit

final class AppViewController: UIViewController {
    
    let appView = AppView()
    
    override func loadView() {
        super.loadView()
        view = appView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationController()
    }
    
    func setupNavigationController() {
        navigationItem.title = "App"
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}
