//
//  TranslateResponseModel.swift
//  Translator
//
//  Created by Sang hun Lee on 2022/06/20.
//

import Foundation

struct TranslateResponseModel: Decodable {
    let message: Message
    
    var translatedText: String { message.result.translatedText }
    
    struct Message: Decodable {
        let result: Result
    }
    
    struct Result: Decodable {
        let translatedText: String
    }
}
