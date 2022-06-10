//
//  MainViewModel.swift
//  BlogCafeSearch
//
//  Created by Sang hun Lee on 2022/06/10.
//

import Foundation
import RxSwift
import RxCocoa

struct MainViewModel {
    let disposeBag = DisposeBag()
    
    let resultListViewModel = ResultListViewModel()
    let searchBarViewModel = SearchBarViewModel()
    
    let alertActionTapped = PublishRelay<MainViewController.AlertAction>()
    let shouldPresentAlert: Signal<MainViewController.Alert>
    
    init(model: MainModel = MainModel()) {
        let blogResult = searchBarViewModel.shouldLoadResult
            .flatMapLatest { query in
                model.searchBlog(query)
            }
            .share()
            
        let blogValue = blogResult
            .compactMap { data -> DaumKakaoBlog? in
                model.getBlogValue(data)
            }
        
        let blogError = blogResult
            .compactMap { data -> String? in
                model.getBlogError(data)
            }
        
        // 네트워크를 통해 가져온 값을 cellData로 변환
        let cellData = blogValue
            .map { blog -> [ResultListCellData] in
                model.getResultListCellData(blog)
            }
        
        // Filter 뷰 선택시 AlertSheet를 선택했을 때 Type
        let sortedType = alertActionTapped
            .filter {
                switch $0 {
                case .title, .datetime:
                    return true
                default:
                    return false
                }
            }
            .startWith(.title)
        
        // MainView에서 ListView 데이터 전달
        Observable
            .combineLatest(
                cellData,
                sortedType,
                resultSelector: { data, type -> [ResultListCellData] in
                    model.listSort(by: type, of: data)
                }
            )
            .bind(to: resultListViewModel.resultCellData)
            .disposed(by: disposeBag)
        
        let alertSheetForSorting = resultListViewModel.filterViewModel.sortButtonTapped
            // 탭을 알럿으로 전환
            .map { _ -> MainViewController.Alert in
                return (title: nil, message: nil, actions: [.title, .datetime, .cancel], style: .actionSheet)
            }
        
        let alertForErrorMessage = blogError
            .map { message -> MainViewController.Alert in
                return (
                    title: "Error!",
                    message: "예상치 못한 오류가 발생했습니다. 잠시후 다시 시도해주세요. \(message)",
                    actions: [.confirm],
                    style: .alert
                )
            }
        
        self.shouldPresentAlert = Observable
            .merge(
                alertSheetForSorting,
                alertForErrorMessage
            )
            .asSignal(onErrorSignalWith: .empty())
    }
}
