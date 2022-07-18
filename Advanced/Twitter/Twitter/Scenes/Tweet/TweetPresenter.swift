//
//  TweetPresenter.swift
//  Twitter
//
//  Created by Sang hun Lee on 2022/07/18.
//

import Foundation

protocol TweetProtocol: AnyObject {
    func setupView()
    func setupConstraints()
    func configureView(tweet: Tweet)
}

final class TweetPresenter: NSObject {
    private weak var viewController: TweetProtocol?
    private let tweet: Tweet
    
    init(viewController: TweetProtocol, tweet: Tweet) {
        self.viewController = viewController
        self.tweet = tweet
    }
    
    func viewDidLoad() {
        viewController?.configureView(tweet: tweet)
        viewController?.setupView()
        viewController?.setupConstraints()
    }
}
