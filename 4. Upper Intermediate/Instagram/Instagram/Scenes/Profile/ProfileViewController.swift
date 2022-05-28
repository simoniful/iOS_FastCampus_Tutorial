//
//  ProfileViewController.swift
//  Instagram
//
//  Created by Sang hun Lee on 2022/05/28.
//

import UIKit
import SnapKit

final class ProfileViewController: UIViewController {
    let profileView = ProfileView()
    
    override func loadView() {
        super.loadView()
        self.view = profileView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
    }

    
}

private extension ProfileViewController {
    func setNavigationBar() {
        navigationItem.title = "UserName"
        let rightBarButton = UIBarButtonItem(
            image: UIImage(systemName: "ellipsis"),
            style: .plain,
            target: self,
            action: nil
        )
        navigationItem.rightBarButtonItem = rightBarButton
    }
}
