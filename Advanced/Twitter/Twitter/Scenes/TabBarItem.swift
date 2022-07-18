//
//  TabBarItem.swift
//  Twitter
//
//  Created by Sang hun Lee on 2022/07/18.
//

import UIKit

enum TabBarItem: CaseIterable {
    case feed
    case profile
    
    var title: String {
        switch self {
        case .feed:
            return "Feed"
        case .profile:
            return "Profile"
        }
    }
    
    var icon: (normal: UIImage?, selected: UIImage?) {
        switch self {
        case .feed:
            return (UIImage(systemName: "list.bullet"), UIImage(systemName: "list.bullet"))
        case .profile:
            return (UIImage(systemName: "person"), UIImage(systemName: "person.fill"))
        }
    }
    
    var viewController: UIViewController {
        switch self {
        case .feed:
            return UINavigationController(rootViewController: FeedViewController())
        case .profile:
            return UIViewController()
        }
    }
}
