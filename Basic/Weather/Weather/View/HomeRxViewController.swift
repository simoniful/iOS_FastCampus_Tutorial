//
//  HomeRxViewController.swift
//  Weather
//
//  Created by Sang hun Lee on 2022/04/30.
//

import Foundation

import UIKit
import RxSwift
import RxCocoa

class HomeRxViewController: UIViewController {
    let disposeBag = DisposeBag()
    
    private let homeView = HomeView()
    private let homeViewModel = HomeViewModel()
    
    override func loadView() {
        self.view = homeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    func bind() {
        let input = HomeViewModel.Input(
            searchButtonTap: homeView.searchButton.rx.tap.asObservable(),
            textFieldText: homeView.searchTextField.rx.text.orEmpty.asObservable()
        )
        
        let output = homeViewModel.transform(input: input)
        
        output.weatherInfo
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] data in
                if let data = data {
                    self?.configureView(data: data)
                } else {
                    self?.alertError()
                    self?.homeView.stackView.isHidden = true
                }
            })
            .disposed(by: disposeBag)
    }
    
    func configureView(data: WeatherInfo) {
        self.view.endEditing(true)
        homeView.stackView.isHidden = false
        homeView.cityNameLabel.text = data.name
        homeView.temperatureLabel.text = "\(data.main.temp)°C"
        homeView.minTemperLabel.text = "최저: \(data.main.tempMin)°C"
        homeView.maxTemperLabel.text = "최고: \(data.main.tempMax)°C"
        homeView.weatherStatusLabel.text = data.weather.first?.weatherDescription
    }
    
    func alertError() {
        self.view.endEditing(true)
        let alert =  UIAlertController(title: "에러", message: "도시 이름을 확인해주세요", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
