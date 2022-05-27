//
//  SceneDelegate.swift
//  Subway
//
//  Created by Sang hun Lee on 2022/05/27.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let rootViewController = SearchViewController()
        
        window = UIWindow(windowScene: windowScene)
        window?.backgroundColor = .systemBackground
        
        window?.rootViewController = UINavigationController(rootViewController: rootViewController)
        window?.makeKeyAndVisible()
        
    }
}

