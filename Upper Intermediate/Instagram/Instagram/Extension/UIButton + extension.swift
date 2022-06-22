//
//  UIButton + extension.swift
//  Instagram
//
//  Created by Sang hun Lee on 2022/05/28.
//

import UIKit

extension UIButton {
    func setImage(systemName: String) {
        contentHorizontalAlignment = .fill
        contentVerticalAlignment = .fill

        imageView?.contentMode = .scaleAspectFit
        imageEdgeInsets = .zero

        setImage(UIImage(systemName: systemName), for: .normal)
    }
}
