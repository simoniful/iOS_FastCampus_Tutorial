//
//  WeatherEnvelop.swift
//  Weather
//
//  Created by Sang hun Lee on 2022/04/29.
//

import Foundation

extension CodingUserInfoKey {
  static let contentIdentifier = CodingUserInfoKey(rawValue: "contentIdentifier")!
}

struct WeatherResult<Content: Decodable>: Decodable {
  
  let content: Content
  
  private struct CodingKeys: CodingKey {
    var stringValue: String
    var intValue: Int? = nil
    
    init?(stringValue: String) {
        self.stringValue = stringValue
        self.intValue = 0
    }
    
    init?(intValue: Int) {
      return nil
    }
  }
  
  init(from decoder: Decoder) throws {
    guard let ci = decoder.userInfo[CodingUserInfoKey.contentIdentifier],
          let contentIdentifier = ci as? String,
          let key = CodingKeys(stringValue: contentIdentifier) else {
      throw WeatherError.invalidDecoderConfiguration
    }
    
    do {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        content = try container.decode(Content.self, forKey: key)
        print(content)
    } catch {
        print(error.localizedDescription)
        throw error
    }
  }
}
