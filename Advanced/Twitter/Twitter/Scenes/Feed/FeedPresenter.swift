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
}

final class FeedPresenter: NSObject {
    private weak var viewController: FeedProtocol?
    
    init(viewController: FeedProtocol) {
        self.viewController = viewController
    }
    
    func viewDidLoad() {
        viewController?.setupView()
        viewController?.setupConstraints()
    }
}

extension FeedPresenter: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: FeedTableViewCell.identifier,
            for: indexPath
        ) as? FeedTableViewCell else { return UITableViewCell() }
        let tweet = Tweet(user: User.shared, contents: "안녕하세요")
        cell.configureCell(tweet: tweet)
        
        return cell
    }
}

extension FeedPresenter: UITableViewDelegate {
    
}
