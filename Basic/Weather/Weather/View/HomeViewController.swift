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
    
    private let homeView = HomeView()
    
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
            newWeatherInfo
                .observe(on: MainScheduler.instance)
                .subscribe { [weak self] data in
                    self?.configureView(data: data)
                } onError: { [weak self] error in
                    self?.alertError()
                    self?.homeView.stackView.isHidden = true
                }
                .disposed(by: disposeBag)
            self.view.endEditing(true)
        }
    }
    
    func configureView(data: WeatherInfo) {
        homeView.stackView.isHidden = false
        homeView.cityNameLabel.text = data.name
        homeView.temperatureLabel.text = "\(data.main.temp)°C"
        homeView.minTemperLabel.text = "최저: \(data.main.tempMin)°C"
        homeView.maxTemperLabel.text = "최고: \(data.main.tempMax)°C"
        homeView.weatherStatusLabel.text = data.weather.first?.weatherDescription
    }
    
    func alertError() {
        let alert =  UIAlertController(title: "에러", message: "도시 이름을 확인해주세요", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}


