//
//  MovieDetailPresenter.swift
//  MovieRating
//
//  Created by Sang hun Lee on 2022/06/23.
//

import UIKit

protocol MovieDetailProtocol: AnyObject {
    func setupView(with movie: Movie)
    func setRightBarButton(with isLiked: Bool)
}

final class MovieDetailPresenter: NSObject {
    private weak var viewController: MovieDetailProtocol?
    private let userDefaultsManager: UserDefaultsManagerProtocol
    var movie: Movie
    
    init(
        viewController: MovieDetailProtocol,
        userDefaultsManager: UserDefaultsManagerProtocol = UserDefaultsManager(),
        movie: Movie
    ) {
        self.viewController = viewController
        self.userDefaultsManager = userDefaultsManager
        self.movie = movie
    }
    
    func viewDidLoad() {
        viewController?.setupView(with: movie)
        viewController?.setRightBarButton(with: movie.isLiked)
    }
    
    func didTapRightBarButtonItem() {
        movie.isLiked.toggle()
        if movie.isLiked {
            userDefaultsManager.addMovie(movie)
        } else {
            userDefaultsManager.removeMovie(movie)
        }
        viewController?.setRightBarButton(with: movie.isLiked)
    }
}
