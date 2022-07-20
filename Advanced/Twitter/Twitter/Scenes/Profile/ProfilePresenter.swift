//
//  ProfilePresenter.swift
//  Twitter
//
//  Created by Sang hun Lee on 2022/07/20.
//

import Foundation

protocol ProfileProtocol: AnyObject {
    func setupView()
    func setupConstraints()
    func setupNavigation()
    func configureView(with name: String, account: String)
    func endEditing()
    func showToast(message: String)
}

final class ProfilePresenter {
    private weak var viewController: ProfileProtocol?
    private var user: User {
        get { User.shared }
        set { User.shared = newValue }
    }
    
    init(viewController: ProfileProtocol) {
        self.viewController = viewController
    }
    
    func viewDidLoad() {
        viewController?.setupView()
        viewController?.setupConstraints()
        viewController?.setupNavigation()
        viewController?.configureView(with: user.name, account: user.account)
    }
    
    func didTapSaveButton(name: String?, account: String?) {
        if name == nil || name == "" || account == nil || account == "" {
            viewController?.showToast(message: "변경하고자 하는 내용을 입력해주세요")
            return
        }
        
        viewController?.endEditing()
        
        if let name = name {
            user.name = name
        }
        
        if let account = account {
            user.account = account
        }
        
        viewController?.configureView(with: user.name, account: user.account)
        viewController?.showToast(message: "변경이 완료되었습니다")
    }
}
