//
//  MainViewModel.swift
//  Daangn
//
//  Created by Sang hun Lee on 2022/06/10.
//

import Foundation
import RxSwift
import RxCocoa

struct MainViewModel {
    let titleTextFieldCellModel = TitleTextFieldCellModel()
    let priceTextFieldCellModel = PriceTextFieldCellModel()
    let detailWriteFormCellModel = DetailWriteFormCellModel()
    
    // ViewModel -> View
    let cellData: Driver<[String]>
    let presentAlert: Signal<Alert>
    let push: Driver<CategoryViewModel>
    
    // View -> ViewModel
    let itemSelected = PublishRelay<Int>()
    let submitButtonTapped = PublishRelay<Void>()
    
    init(_ viewModel: MainModel = MainModel()) {
        let title = Observable.just("글 제목")
        let categoryViewModel = CategoryViewModel()
        let category = categoryViewModel
            .selectedCategory
            .map { $0.name }
            .startWith("카테고리 선택")
        
        let price = Observable.just("₩ 가격 (선택사항)")
        
        let detail = Observable.just("내용을 입력하세요")
        
        self.cellData = Observable
            .combineLatest(
                title,
                category,
                price,
                detail
            ) { [$0, $1, $2, $3] }
            .asDriver(onErrorJustReturn: [])
        
        let titleMessage = titleTextFieldCellModel.titleText
            .map { $0?.isEmpty ?? true }
            .startWith(true)
            .map { $0 ? ["- 글 제목을 입력해주세요"] : [] }
        
        let categoryMessage = categoryViewModel.selectedCategory
            .map{ _ in false }
            .startWith(true)
            .map { $0 ? ["- 카테고리를 선택해주세요"] : [] }
        
        let detailMessage = detailWriteFormCellModel.detailContentText
            .map { $0?.isEmpty ?? true }
            .startWith(true)
            .map { $0 ? ["- 글 내용을 입력해주세요"] : [] }
        
        let errorMessage = Observable.combineLatest(
            titleMessage,
            categoryMessage,
            detailMessage
        ) { $0 + $1 + $2 }
        
        self.presentAlert = submitButtonTapped
            .withLatestFrom(errorMessage)
            .map { errorMessage -> (title:String, message: String?) in
                viewModel.setAlert(errorMessage: errorMessage)
            }
            .asSignal(onErrorSignalWith: .empty())
        
        self.push = itemSelected
            .compactMap({ row -> CategoryViewModel? in
                guard case 1 = row else {
                    return nil
                }
                return categoryViewModel
            })
            .asDriver(onErrorDriveWith: .empty())
    }
}

