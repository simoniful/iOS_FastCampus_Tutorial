//
//  ViewController.swift
//  Covid-19
//
//  Created by Sang hun Lee on 2022/05/07.
//

import UIKit

class MainViewController: UIViewController {

    let API_KEY = Bundle.main.object(forInfoDictionaryKey: "API_KEY") as? String
    
    let mainView = MainView()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}

