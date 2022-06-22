//
//  CityCovidOverView.swift
//  Covid-19
//
//  Created by Sang hun Lee on 2022/05/09.
//

import Foundation

struct CovidOverview: Codable {
    let countryName: String
    let newCase: String
    let totalCase: String
    let recovered: String
    let death: String
    let percentage: String
    let newCcase: String
    let newFcase: String
}

struct CityCovidOverview: Codable {
    let korea, seoul, busan, daegu: CovidOverview
    let incheon, gwangju, daejeon, ulsan: CovidOverview
    let sejong, gyeonggi, gangwon, chungbuk: CovidOverview
    let chungnam, jeonbuk, jeonnam, gyeongbuk: CovidOverview
    let gyeongnam, jeju, quarantine: CovidOverview
}
