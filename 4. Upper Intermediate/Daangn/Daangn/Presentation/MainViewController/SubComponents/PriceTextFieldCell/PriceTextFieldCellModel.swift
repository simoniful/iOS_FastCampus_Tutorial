//
//  PriceTextFieldCellModel.swift
//  Daangn
//
//  Created by Sang hun Lee on 2022/06/10.
//

import Foundation
import RxSwift
import RxCocoa

struct PriceTextFieldCellModel {
    // ViewModel -> View
    let showFreeShareButton: Signal<Bool>
    let resetPrice: Signal<Void>
    
    // View -> ViewModel
    let priceText = PublishRelay<String?>()
    let freeShareButtonTapped = PublishRelay<Void>()
    
    init() {
        self.showFreeShareButton = Observable
            .merge(
                priceText.map { $0 ?? "" == "0" },
                freeShareButtonTapped.map { _ in false }
            )
            .asSignal(onErrorJustReturn: false)
        
        self.resetPrice = freeShareButtonTapped
            .asSignal(onErrorSignalWith: .empty())
    }
}
