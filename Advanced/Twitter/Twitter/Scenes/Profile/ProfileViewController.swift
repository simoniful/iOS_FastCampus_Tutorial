//
//  ProfileViewController.swift
//  Twitter
//
//  Created by Sang hun Lee on 2022/07/20.
//

import UIKit
import SnapKit
import Toast

final class ProfileViewController: UIViewController {
    private lazy var presenter = ProfilePresenter(viewController: self)
    
    private lazy var nameTextField: UITextField = {
        let textField = UITextField()
        textField.font = .systemFont(ofSize: 20.0, weight: .medium)
        textField.delegate = self
        return textField
    }()
    
    private lazy var accountTextField: UITextField = {
        let textField = UITextField()
        textField.font = .systemFont(ofSize: 16.0, weight: .bold)
        textField.delegate = self
        return textField
    }()
    
    private lazy var saveButton: UIButton = {
        let button = UIButton()
        button.setTitle("저장하기", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15.0, weight: .bold)
        button.contentEdgeInsets = UIEdgeInsets(
            top: 8.0, left: 8.0, bottom: 8.0, right: 8.0
        )
        button.clipsToBounds = true
        button.layer.cornerRadius = 15.0
        button.backgroundColor = .systemBlue
        button.setTitleColor(UIColor.white, for: .normal)
        button.addTarget(self, action: #selector(didTapSaveButton), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
}

private extension ProfileViewController {
    @objc func didTapSaveButton() {
        presenter.didTapSaveButton(
            name: nameTextField.text,
            account: accountTextField.text
        )
    }
}

extension ProfileViewController: ProfileProtocol {
    func setupView() {
        [nameTextField, accountTextField, saveButton].forEach {
            view.addSubview($0)
        }
    }
    
    func setupConstraints() {
        let superviewInset: CGFloat = 16.0
        
        nameTextField.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(superviewInset)
            $0.leading.equalToSuperview().inset(superviewInset)
            $0.trailing.equalToSuperview().inset(superviewInset)
        }
        
        accountTextField.snp.makeConstraints {
            $0.top.equalTo(nameTextField.snp.bottom).offset(superviewInset)
            $0.leading.equalTo(nameTextField.snp.leading)
            $0.trailing.equalTo(nameTextField.snp.trailing)
        }
        
        saveButton.snp.makeConstraints {
            $0.top.equalTo(accountTextField.snp.bottom).offset(32.0)
            $0.leading.equalTo(nameTextField.snp.leading)
            $0.trailing.equalTo(nameTextField.snp.trailing)
            $0.height.equalTo(44.0)
        }
    }
    
    func setupNavigation() {
        navigationItem.title = "Profile"
    }
    
    func configureView(with name: String, account: String) {
        nameTextField.text = name
        accountTextField.text = account
    }
    
    func endEditing() {
        view.endEditing(true)
    }
    
    func showToast(message: String) {
        view.makeToast(message)
    }
}

extension ProfileViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
