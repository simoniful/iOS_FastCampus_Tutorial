//
//  ViewController.swift
//  Covid-19
//
//  Created by Sang hun Lee on 2022/05/07.
//

import UIKit
import Alamofire

class MainViewController: UIViewController {

    let API_KEY = Bundle.main.object(forInfoDictionaryKey: "API_KEY") as? String
    
    let mainView = MainView()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fetchCovidOverview { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(result):
                debugPrint("success \(result)")
            case let .failure(error):
                debugPrint("error \(error)")
            }
        }
    }

    // 탈출 클로저를 통한 비동기 작업 수행
    func fetchCovidOverview(completionHandler: @escaping (Result<CityCovidOverview, Error>) -> Void) {
        let url = "https://api.corona-19.kr/korea/country/new/"
        let params = [
            "serviceKey": API_KEY
        ]
        AF.request(url, method: .get, parameters: params).responseData { response in
            switch response.result {
            case let .success(data):
                do {
                    let decorder = JSONDecoder()
                    let result = try decorder.decode(CityCovidOverview.self, from: data)
                    completionHandler(.success(result))
                } catch {
                    completionHandler(.failure(error))
                }
            case let .failure(error):
                completionHandler(.failure(error))
            }
        }
    }
}

