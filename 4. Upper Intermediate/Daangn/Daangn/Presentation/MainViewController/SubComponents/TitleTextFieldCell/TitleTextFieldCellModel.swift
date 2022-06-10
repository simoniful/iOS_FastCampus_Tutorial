//
//  TitleTextFieldCellModel.swift
//  Daangn
//
//  Created by Sang hun Lee on 2022/06/10.
//

import Foundation
import RxSwift
import RxCocoa

struct TitleTextFieldCellModel {
    let titleText = PublishRelay<String?>()
}
