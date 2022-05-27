//
//  StationResponseModel.swift
//  Subway
//
//  Created by Sang hun Lee on 2022/05/27.
//

import Foundation

// MARK: - StationResponseModel
struct StationResponseModel: Codable {
    var searchInfo: SearchInfoBySubwayNameService

    enum CodingKeys: String, CodingKey {
        case searchInfo = "SearchInfoBySubwayNameService"
    }
}

// MARK: - SearchInfoBySubwayNameService
struct SearchInfoBySubwayNameService: Codable {
    var listTotalCount: Int
    var result: Result
    var row: [Row]

    enum CodingKeys: String, CodingKey {
        case listTotalCount = "list_total_count"
        case result = "RESULT"
        case row
    }
}

// MARK: - Result
struct Result: Codable {
    var code, message: String

    enum CodingKeys: String, CodingKey {
        case code = "CODE"
        case message = "MESSAGE"
    }
}

// MARK: - Row
struct Row: Codable {
    var stationCode, stationName, lineNumber, frCode: String

    enum CodingKeys: String, CodingKey {
        case stationCode = "STATION_CD"
        case stationName = "STATION_NM"
        case lineNumber = "LINE_NUM"
        case frCode = "FR_CODE"
    }
}


