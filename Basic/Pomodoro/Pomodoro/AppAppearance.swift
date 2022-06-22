//
//  AppAppearance.swift
//  Pomodoro
//
//  Created by Sang hun Lee on 2022/04/26.
//

import UIKit

final class AppAppearance {
    static func setupAppearance() {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .systemBackground
        appearance.titleTextAttributes = [.foregroundColor: UIColor.label]
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().tintColor = .label
        UINavigationBar.appearance().barTintColor = .label
    }
}
