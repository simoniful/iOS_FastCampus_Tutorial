//
//  ViewModelType.swift
//  Weather
//
//  Created by Sang hun Lee on 2022/04/29.
//

import Foundation
import RxSwift

protocol ViewModelType {
    
    associatedtype Input
    associatedtype Output
    
    var disposeBag: DisposeBag { get set }
    
    func transform(input: Input) -> Output
}
