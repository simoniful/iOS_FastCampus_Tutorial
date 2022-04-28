//
//  ViewController.swift
//  Weather
//
//  Created by Sang hun Lee on 2022/04/28.
//

import UIKit

class HomeViewController: UIViewController {

    private let homeView = HomeView()
    private let apiKey = Bundle.main.object(forInfoDictionaryKey: "API_KEY") as? String
    
    
    override func loadView() {
        self.view = homeView
        print(apiKey)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    
}

