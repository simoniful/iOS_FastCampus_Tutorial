//
//  ViewModelType.swift
//  Covid-19
//
//  Created by Sang hun Lee on 2022/05/07.
//

import Foundation
import RxSwift

protocol ViewModelType {
    
    associatedtype Input
    associatedtype Output
    
    var disposeBag: DisposeBag { get set }
    
    func transform(input: Input) -> Output
}
