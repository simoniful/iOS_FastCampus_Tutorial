//
//  RepositoryListViewController.swift
//  GitHub
//
//  Created by Sang hun Lee on 2022/06/02.
//

import UIKit
import RxSwift
import RxCocoa

class RepositoryListViewController: UITableViewController {
    // MARK: - Property
    private let organiztion = "ReactiveX"
    private let repositories = BehaviorSubject<[Repository]>(value: [])
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = organiztion + "Repository"
        setuprefreshControl()
        tableView.register(RepositoryListViewCell.self, forCellReuseIdentifier: RepositoryListViewCell.identifier)
        tableView.rowHeight = 140
    }
    
    // MARK: - UITableView RefreshControl Setup
    func setuprefreshControl() {
        self.refreshControl = UIRefreshControl()
        let refreshControl = self.refreshControl
        refreshControl?.backgroundColor = .white
        refreshControl?.tintColor = .darkGray
        refreshControl?.attributedTitle = NSAttributedString(string: "당겨서 새로고침")
        refreshControl?.addTarget(self, action: #selector(refresh), for: .valueChanged)
    }
    
    @objc func refresh() {
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let self = self else { return }
            self.fetchRepositories(of: self.organiztion)
        }
    }
    
    // MARK: - Data Fetch with Rx
    func fetchRepositories(of organiztion: String) {
        Observable.from([organiztion])
            .map { organiztion -> URL in
                return URL(string: "https://api.github.com/orgs/\(organiztion)/repos")!
            }
            .map { url -> URLRequest in
                var request = URLRequest(url: url)
                request.httpMethod = "GET"
                return request
            }
            // URLSession 요청을 통한 Observable 튜플 수신
            .flatMap { request -> Observable<(response: HTTPURLResponse, data: Data)> in
                return URLSession.shared.rx.response(request: request)
            }
            // statusCode로 걸러내기
            .filter { (response, _) in
                return 200..<300 ~= response.statusCode
            }
            // data 타입의 Json화
            .map { (_, data) -> [[String: Any]] in
                guard let json = try? JSONSerialization.jsonObject(with: data, options: []),
                      let result = json as? [[String: Any]] else {
                    return []
                }
                return result
            }
            .filter { result in
                result.count > 0
            }
            .map { objects in
                // compactMap nil 제거 및 직접적인 decode
                return objects.compactMap { dict -> Repository? in
                    guard let id = dict["id"] as? Int,
                          let name = dict["name"] as? String,
                          let description = dict["description"] as? String,
                          let stargazersCount = dict["stargazers_count"] as? Int,
                          let language = dict["language"] as? String else {
                        return nil
                    }
                    return Repository(id: id, name: name, description: description, stargazersCount: stargazersCount, language: language)
                }
            }
            .subscribe(onNext: { [weak self] newRepositories in
                self?.repositories.onNext(newRepositories)
                
                // UI 반영 - Binding으로 변경 필요
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                    self?.refreshControl?.endRefreshing()
                }
            })
            .disposed(by: disposeBag)
    }
}

// MARK: - UITableView DataSource Delegate
extension RepositoryListViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        do {
            return try repositories.value().count
        } catch {
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RepositoryListViewCell.identifier, for: indexPath)
                as? RepositoryListViewCell else { return UITableViewCell() }
        var currentRepo: Repository? {
            do {
                return try repositories.value()[indexPath.row]
            } catch {
                return nil
            }
        }
        cell.repository = currentRepo
        return cell
    }
}

