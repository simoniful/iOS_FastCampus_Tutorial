//
//  SearchBlogNetwork.swift
//  BlogCafeSearch
//
//  Created by Sang hun Lee on 2022/06/07.
//

import Foundation
import RxSwift

enum SearchNetworkError: Error {
    case invalidURL
    case invalidJSON
    case networkError
}

class SearchBlogNetwork {
    private let session: URLSession
    let api = SearchBlogAPI()
    let API_KEY = Bundle.main.object(forInfoDictionaryKey: "API_KEY") as! String
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func searchBlog(query: String) -> Single<Result<DaumKakaoBlog, SearchNetworkError>> {
        guard let url = api.searchBlog(query: query).url else {
            return .just(.failure(.invalidURL))
        }
        
        let request = NSMutableURLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("KakaoAK \(API_KEY)", forHTTPHeaderField: "Authorization")
        
        return session.rx.data(request: request as URLRequest)
            .asSingle()
            .map { data in
                do {
                    let blogData = try JSONDecoder().decode(DaumKakaoBlog.self, from: data)
                    return .success(blogData)
                } catch {
                    return .failure(.invalidJSON)
                }
            }
            .catch { _ in
                    .just(.failure(.networkError))
            }
    }
}
