//
//  ViewController.swift
//  Weather
//
//  Created by Sang hun Lee on 2022/04/28.
//

import UIKit
import RxSwift
import RxCocoa

class HomeViewController: UIViewController {
    let disposeBag = DisposeBag()
    // let weatherInfo = PublishRelay<WeatherInfo>()
    
    private let homeView = HomeView()
    private let homeViewModel = HomeViewModel()
    
    override func loadView() {
        self.view = homeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        homeView.searchButton.addTarget(self, action: #selector(searchButtonTap) , for: .touchUpInside)
    }
    
    @objc func searchButtonTap() {
        if let cityName = self.homeView.searchTextField.text {
            let newWeatherInfo = WeatherNetwork.shared().getWeatherInfo(cityname: cityName)
            // single 활용? - 사이드 이펙트 분리
            newWeatherInfo
            .subscribe { [weak self] data in
                DispatchQueue.main.async {
                    self?.homeView.stackView.isHidden = false
                    self?.homeView.cityNameLabel.text = data.name
                    self?.homeView.minTemperLabel.text = "\(data.main.tempMin)"
                    self?.homeView.maxTemperLabel.text = "\(data.main.tempMax)"
                    self?.homeView.weatherStatusLabel.text = data.weather.first?.main
                }
            } onError: { [weak self] error in
                DispatchQueue.main.async {
                    print(error.localizedDescription)
                    self?.homeView.stackView.isHidden = true
                }
            }
            .disposed(by: disposeBag)
            self.view.endEditing(true)
            
        }
    }
}


