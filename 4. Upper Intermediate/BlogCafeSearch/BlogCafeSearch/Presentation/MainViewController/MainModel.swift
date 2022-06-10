//
//  MainModel.swift
//  BlogCafeSearch
//
//  Created by Sang hun Lee on 2022/06/10.
//

import Foundation
import RxSwift

struct MainModel {
    let network = SearchBlogNetwork()
    
    func searchBlog(_ query: String) -> Single<Result<DaumKakaoBlog, SearchNetworkError>> {
        return network.searchBlog(query: query)
    }
    
    func getBlogValue(_ result: Result<DaumKakaoBlog, SearchNetworkError>) -> DaumKakaoBlog? {
        guard case .success(let value) = result else {
            return nil
        }
        return value
    }
    
    func getBlogError(_ result: Result<DaumKakaoBlog, SearchNetworkError>) -> String? {
        guard case .failure(let error) = result else {
            return nil
        }
        return error.localizedDescription
    }
    
    func getResultListCellData(_ value: DaumKakaoBlog) -> [ResultListCellData] {
        return value.documents
            .map { doc in
                let thumbnailURL = URL(string: doc.thumbnail ?? "")
                return ResultListCellData(
                    thumbnailURL: thumbnailURL,
                    name: doc.name,
                    title: doc.title,
                    datetime: doc.datetime
                )
            }
    }
    
    func listSort(by type: MainViewController.AlertAction, of data: [ResultListCellData]) -> [ResultListCellData] {
        switch type {
        case .title:
            return data.sorted { $0.title ?? "" < $1.title ?? "" }
        case .datetime:
            return data.sorted { $0.datetime ?? Date() < $1.datetime ?? Date() }
        default:
            return data
        }
    }
}
