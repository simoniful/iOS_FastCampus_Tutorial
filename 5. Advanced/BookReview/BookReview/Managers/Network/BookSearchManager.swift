//
//  BookSearchManager.swift
//  BookReview
//
//  Created by Sang hun Lee on 2022/06/21.
//

import Foundation
import Alamofire

struct BookSearchManager {
    func request(from keyword: String, completionHandler: @escaping ([Book]) -> ()) {
        guard let url = URL(string: "https://openapi.naver.com/v1/search/book.json") else { return }
        
        let parameters = BookSearchRequestModel(query: keyword)
        
        let X_Naver_Client_Id = Bundle.main.object(forInfoDictionaryKey: "X_Naver_Client_Id") as! String
        let X_Naver_Client_Secret = Bundle.main.object(forInfoDictionaryKey: "X_Naver_Client_Secret") as! String
        
        let headers: HTTPHeaders = [
            "X-Naver-Client-Id": X_Naver_Client_Id,
            "X-Naver-Client-Secret": X_Naver_Client_Secret
        ]

        AF
            .request(url, method: .get, parameters: parameters, headers: headers)
            .responseDecodable(of: BookSearchResponseModel.self) { response in
                switch response.result {
                case .success(let result):
                    completionHandler(result.items)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            .resume()
    }
}
