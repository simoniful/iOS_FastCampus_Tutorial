//
//  WritePresenter.swift
//  Twitter
//
//  Created by Sang hun Lee on 2022/07/19.
//

import Foundation

protocol WriteProtocol: AnyObject {
    func setupView()
    func setupConstraints()
    func setupNavigation()
    func dismiss()
}

final class WritePresenter: NSObject {
    private weak var viewController: WriteProtocol?
    private let userDefaultManager: UserDefaultManagerProtocol
    
    init(
        viewController: WriteProtocol,
        userDefaultManager: UserDefaultManagerProtocol = UserDefaultManager()
    ) {
        self.viewController = viewController
        self.userDefaultManager = userDefaultManager
    }
    
    func viewDidLoad() {
        viewController?.setupNavigation()
        viewController?.setupView()
        viewController?.setupConstraints()
    }
    
    func didTapLeftBarButtonItem() {
        viewController?.dismiss()
    }
    
    func didTapRightBarButtonItem(text: String) {
        let tweet = Tweet(user: User.shared, contents: text)
        userDefaultManager.setTweet(tweet)
        viewController?.dismiss()
    }
}


