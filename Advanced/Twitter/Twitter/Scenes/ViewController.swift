//
//  ViewController.swift
//  Twitter
//
//  Created by Sang hun Lee on 2022/07/18.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let manager = UserDefaultManager()
        manager.setTweet(Tweet(user: User.shared, contents: "안녕하세요"))
        
        print(manager.getTweet())
    }
}

