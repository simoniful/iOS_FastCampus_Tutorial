//
//  HomeViewModel.swift
//  Weather
//
//  Created by Sang hun Lee on 2022/04/30.
//

import Foundation
import RxSwift
import RxCocoa

class HomeViewModel: ViewModelType {
    var disposeBag = DisposeBag()
    
    struct Input {
        let searchButtonTap: Observable<Void>
        let textFieldText: Observable<String>
    }
    
    struct Output {
        let weatherInfo: Observable<WeatherInfo?>
    }
    
    var inputText = BehaviorRelay(value: "")
    var weatherInfo = PublishSubject<WeatherInfo?>()
    
    func transform(input: Input) -> Output {
        input.textFieldText
            .bind(to: inputText)
            .disposed(by: disposeBag)

        input.searchButtonTap
            .bind { _ in
                let newWeatherInfo = WeatherNetwork.shared().getWeatherInfo(cityname: self.inputText.value)
                newWeatherInfo
                    .subscribe(
                        onNext: { data in
                            self.weatherInfo.onNext(data)
                        },
                        onError: { error in
                            self.weatherInfo.onNext(nil)
                        })
                    .disposed(by: self.disposeBag)
            }
            .disposed(by: disposeBag)
        
        return Output(weatherInfo: weatherInfo)
    }
    
}
