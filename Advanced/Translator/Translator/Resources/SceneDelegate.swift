//
//  SceneDelegate.swift
//  Translator
//
//  Created by Sang hun Lee on 2022/06/17.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let rootViewController = TabBarController()
        window = UIWindow(windowScene: windowScene)
        window?.backgroundColor = .systemBackground
        window?.rootViewController = rootViewController
        window?.tintColor = .mainTintColor
        window?.makeKeyAndVisible()
    }
}

