//
//  ViewController.swift
//  CalamityAlarm
//
//  Created by Sang hun Lee on 2022/05/15.
//

import UIKit

class MainViewController: UIViewController {
    let mainView = MainView()
    let API_KEY = Bundle.main.object(forInfoDictionaryKey: "API_KEY") as? String
    
    override func loadView() {
        super.loadView()
        self.view = mainView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        print(API_KEY)
    }
}

