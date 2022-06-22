//
//  ViewModel.swift
//  Pomodoro
//
//  Created by Sang hun Lee on 2022/04/26.
//

import Foundation
import RxSwift
import RxCocoa

class PomoViewModel: ViewModelType {
    var disposeBag = DisposeBag()
    
    struct Input {
        let cancelButtonTap: ControlEvent<Void>
        let toggleButtonTap: ControlEvent<Void>
    }
    
    struct Output {
        let timerTrigger: ControlEvent<Void>
        let timerStop: ControlEvent<Void>
    }
    
    func transform(input: Input) -> Output {
        return Output(timerTrigger: input.toggleButtonTap, timerStop: input.cancelButtonTap)
    }
}
