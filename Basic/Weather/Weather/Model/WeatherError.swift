//
//  WeatherError.swift
//  Weather
//
//  Created by Sang hun Lee on 2022/04/29.
//

import Foundation

enum WeatherError: Error {
    case invalidURL(String)
    case invalidParameter(String, Any)
    case invalidJSON(String)
    case invalidDecoderConfiguration
}
