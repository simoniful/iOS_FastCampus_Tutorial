//
//  ResultListViewModel.swift
//  BlogCafeSearch
//
//  Created by Sang hun Lee on 2022/06/09.
//

import RxSwift
import RxCocoa

struct ResultListViewModel {
    let filterViewModel = FilterViewModel()
    
    // MainViewController -> ResultList 데이터 전달
    let resultCellData = PublishSubject<[ResultListCellData]>()
    let cellData: Driver<[ResultListCellData]>
    
    init() {
        self.cellData = resultCellData
            .asDriver(onErrorJustReturn: [])
    }
}
