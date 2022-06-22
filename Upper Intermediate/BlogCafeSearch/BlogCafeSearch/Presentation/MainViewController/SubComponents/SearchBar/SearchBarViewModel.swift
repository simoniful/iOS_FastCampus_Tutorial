//
//  SearchBarViewModel.swift
//  BlogCafeSearch
//
//  Created by Sang hun Lee on 2022/06/09.
//

import RxSwift
import RxCocoa

struct SearchBarViewModel {
    let queryText = PublishRelay<String?>()
    let shouldLoadResult: Observable<String>
    let searchButtonTapped = PublishRelay<Void>()
    
    init() {
        self.shouldLoadResult = searchButtonTapped
            .withLatestFrom(queryText) { $1 ?? "" }
            .filter{ !$0.isEmpty }
            .distinctUntilChanged()
    }
    
    
}
