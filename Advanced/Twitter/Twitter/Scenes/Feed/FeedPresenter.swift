//
//  FeedPresenter.swift
//  Twitter
//
//  Created by Sang hun Lee on 2022/07/18.
//

import UIKit

protocol FeedProtocol: AnyObject {
    func setupView()
    func setupConstraints()
    func reloadTableView()
    func pushToTweetViewController(with tweet: Tweet)
    func presentWriteViewController()
}

final class FeedPresenter: NSObject {
    private weak var viewController: FeedProtocol?
    private let userDefaultManager: UserDefaultManagerProtocol
    
    private var tweets: [Tweet] = []
    
    init(
        viewController: FeedProtocol,
        userDefaultManager: UserDefaultManagerProtocol = UserDefaultManager()
    ) {
        self.viewController = viewController
        self.userDefaultManager = userDefaultManager
    }
    
    func viewDidLoad() {
        viewController?.setupView()
        viewController?.setupConstraints()
    }
    
    func viewWillAppear() {
        tweets = userDefaultManager.getTweet()
        viewController?.reloadTableView()
    }
    
    func didTapWriteButton() {
        viewController?.presentWriteViewController()
    }
}

extension FeedPresenter: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: FeedTableViewCell.identifier,
            for: indexPath
        ) as? FeedTableViewCell else { return UITableViewCell() }
        let tweet = tweets[indexPath.row]
        cell.configureCell(tweet: tweet)
        
        return cell
    }
}

extension FeedPresenter: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let tweet = tweets[indexPath.row]
        viewController?.pushToTweetViewController(with: tweet)
    }
}
