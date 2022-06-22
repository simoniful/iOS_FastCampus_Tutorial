//
//  AlertActionConvertible.swift
//  BlogCafeSearch
//
//  Created by Sang hun Lee on 2022/06/06.
//

import UIKit

protocol AlertActionConvertible {
    var title: String { get }
    var style: UIAlertAction.Style { get }
}
