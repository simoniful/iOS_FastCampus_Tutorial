//
//  TabBarViewController.swift
//  Twitter
//
//  Created by Sang hun Lee on 2022/07/18.
//

import UIKit

final class TabBarViewController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let tabBarViewControllers: [UIViewController] = TabBarItem.allCases
            .map { tabCase in
                let viewController = tabCase.viewController
                viewController.tabBarItem = UITabBarItem(
                    title: tabCase.title,
                    image: tabCase.icon.normal,
                    selectedImage: tabCase.icon.selected
                )
                return viewController
            }
        self.viewControllers = tabBarViewControllers
    }
}

