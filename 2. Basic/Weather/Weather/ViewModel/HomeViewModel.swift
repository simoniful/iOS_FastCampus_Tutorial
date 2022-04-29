//
//  HomeViewModel.swift
//  Weather
//
//  Created by Sang hun Lee on 2022/04/29.
//

import Foundation
import RxSwift
import RxCocoa

class HomeViewModel: ViewModelType {
    var disposeBag = DisposeBag()
    
    struct Input {
        let textFieldText: BehaviorSubject<String>
        let searchButtonTap: ControlEvent<Void>
    }
    
    struct Output {
        // let presentView: ControlEvent<Void>
    }
    
    func transform(input: Input) -> Output {
        
        
        
        return Output()
    }

}
