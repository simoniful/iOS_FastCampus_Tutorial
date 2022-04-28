//
//  ViewController.swift
//  Weather
//
//  Created by Sang hun Lee on 2022/04/28.
//

import UIKit

class HomeViewController: UIViewController {

    private let homeView = HomeView()
    
    override func loadView() {
        self.view = homeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    
}

