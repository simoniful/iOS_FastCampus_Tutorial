//
//  CommonViewModel.swift
//  Pomodoro
//
//  Created by Sang hun Lee on 2022/04/26.
//

import Foundation
import RxSwift

protocol ViewModelType {
    
    associatedtype Input
    associatedtype Output
    
    var disposeBag: DisposeBag { get set }
    
    func transform(input: Input) -> Output
}
