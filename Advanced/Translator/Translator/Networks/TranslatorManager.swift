//
//  TranslatorManager.swift
//  Translator
//
//  Created by Sang hun Lee on 2022/06/20.
//

import Alamofire // AFNetworking, URLSession
import Foundation

struct TranslatorManager {
    var sourceLanguage: Language = .korean
    var targetLanguage: Language = .english
    
    func translate(from text: String, completionHandler: @escaping (String) -> Void) {
        guard let url = URL(string: "https://openapi.naver.com/v1/papago/n2mt") else { return }
        
        let requestModel = TranslateRequestModel(
            source: sourceLanguage.languageCode,
            target: targetLanguage.languageCode,
            text: text
        )
        
        let X_Naver_Client_Id = Bundle.main.object(forInfoDictionaryKey: "X_Naver_Client_Id") as! String
        let X_Naver_Client_Secret = Bundle.main.object(forInfoDictionaryKey: "X_Naver_Client_Secret") as! String
        
        let headers: HTTPHeaders = [
            "X-Naver-Client-Id": X_Naver_Client_Id,
            "X-Naver-Client-Secret": X_Naver_Client_Secret
        ]
        
        AF
            .request(url, method: .post, parameters: requestModel, headers: headers)
            .responseDecodable(of: TranslateResponseModel.self) { response in
                switch response.result {
                case .success(let result):
                    completionHandler(result.translatedText)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            .resume()
    }
}

