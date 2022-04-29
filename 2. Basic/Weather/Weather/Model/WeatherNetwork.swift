//
//  WeatherNetwork.swift
//  Weather
//
//  Created by Sang hun Lee on 2022/04/29.
//

import Foundation
import RxSwift
import RxCocoa

class WeatherNetwork {
    // MARK: - Singleton
    private static var sharedNetworking: WeatherNetwork = {
        let networking = WeatherNetwork()
        return networking
    }()
    
    class func shared() -> WeatherNetwork {
        return sharedNetworking
    }
    
    let API_KEY = Bundle.main.object(forInfoDictionaryKey: "API_KEY") as! String
    let API = "https://api.openweathermap.org/data/2.5"
    let currentWeatherEndpoint = "/weather"
    
    func getWeatherInfo(cityname: String) -> Observable<WeatherInfo> {
        let request: Observable<WeatherInfo> = request(endpoint: currentWeatherEndpoint, query: ["q" : cityname, "appid" : API_KEY, "units" : "metric"])
        return request
          .map { $0 }
          .share(replay: 1, scope: .forever)
    }
    
    static func jsonDecoder(contentIdentifier: String) -> JSONDecoder {
        let decoder = JSONDecoder()
        decoder.userInfo[.contentIdentifier] = contentIdentifier
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }
    
    func request<T: Decodable>(endpoint: String, query: [String: Any] = [:], contentIdentifier: String = "") -> Observable<T> {
        do {
            guard let url = URL(string: API)?.appendingPathComponent(endpoint),
                  var components = URLComponents(url: url, resolvingAgainstBaseURL: true) else { throw WeatherError.invalidURL(endpoint) }
            
            components.queryItems = try query.compactMap{ (key, value) in
                guard let v = value as? CustomStringConvertible else { throw WeatherError.invalidParameter(key, value) }
                return URLQueryItem(name: key, value: v.description)
            }
        
            guard let finalURL = components.url else { throw WeatherError.invalidURL(endpoint) }
            
            let request = URLRequest(url: finalURL)
            
            return URLSession.shared.rx.response(request: request)
                .map { (result: (response: HTTPURLResponse, data: Data)) -> T in
                    let decoder = JSONDecoder()
                    // 원하는 키를 구성하여 요청에서 제네릭을 활용한 구조체 생성
                    // let decoder = WeatherNetwork.jsonDecoder(contentIdentifier: "")
                    let envelope = try decoder.decode(T.self, from: result.data)
                    // let envelope = try decoder.decode(WeatherResult<T>.self, from: result.data)
                    return envelope
                    // return envelope.content
                }
        } catch {
            return Observable.empty()
        }
    }
}
