//
//  MainViewController.swift
//  ConvenienceStore
//
//  Created by Sang hun Lee on 2022/06/11.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        let API_KEY = Bundle.main.object(forInfoDictionaryKey: "API_KEY") as! String
        let APP_KEY = Bundle.main.object(forInfoDictionaryKey: "APP_KEY") as! String
        
    }
}

