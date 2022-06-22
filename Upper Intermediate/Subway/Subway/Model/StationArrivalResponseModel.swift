//
//  StationArrivalResponseModel.swift
//  Subway
//
//  Created by Sang hun Lee on 2022/05/27.
//

import Foundation

// MARK: - StationArrivalResponseModel
struct StationArrivalResponseModel: Codable {
    var errorMessage: ErrorMessage
    var realtimeArrivalList: [RealtimeArrivalList]
}

// MARK: - ErrorMessage
struct ErrorMessage: Codable {
    var status: Int
    var code, message, link, developerMessage: String
    var total: Int
}

// MARK: - RealtimeArrivalList
struct RealtimeArrivalList: Codable {
    var beginRow, endRow, curPage, pageRow: JSONNull?
    var totalCount, rowNum, selectedCount: Int
    var subwayID: String
    var subwayNm: JSONNull?
    var updnLine, trainLineNm, subwayHeading, statnFid: String
    var statnTid, statnID, statnNm: String
    var trainCo: JSONNull?
    var ordkey, subwayList, statnList: String
    var btrainSttus: String?
    var barvlDt, btrainNo, bstatnID, bstatnNm: String
    var recptnDt, arvlMsg2, arvlMsg3, arvlCD: String

    enum CodingKeys: String, CodingKey {
        case beginRow, endRow, curPage, pageRow, totalCount, rowNum, selectedCount
        case subwayID = "subwayId"
        case subwayNm, updnLine, trainLineNm, subwayHeading, statnFid, statnTid
        case statnID = "statnId"
        case statnNm, trainCo, ordkey, subwayList, statnList, btrainSttus, barvlDt, btrainNo
        case bstatnID = "bstatnId"
        case bstatnNm, recptnDt, arvlMsg2, arvlMsg3
        case arvlCD = "arvlCd"
    }
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public func hash(into hasher: inout Hasher) {
        // No-op
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}


