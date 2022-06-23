//
//  MovieListPresenter.swift
//  MovieRating
//
//  Created by Sang hun Lee on 2022/06/22.
//

import UIKit

protocol MovieListProtocol: AnyObject {
    func setupNavigationBar()
    func setupSearchBar()
    func setupView()
    func updateSearchTableView(isHidden: Bool)
    func pushToMovieDetailViewController(with movie: Movie)
    func updateCollectionView()
}

final class MovieListPresenter: NSObject {
    // unowned let / weak var
    private weak var viewController: MovieListProtocol?
    private let movieSearchManager: MovieSearchManagerProtocol
    private let userDefaultsManager : UserDefaultsManagerProtocol
    
    var likedMovies: [Movie] = []
    
    var currentMovieSearchResult: [Movie] = []
    
    init(
        viewController: MovieListProtocol,
        userDefaultsManager: UserDefaultsManagerProtocol = UserDefaultsManager(),
        movieSearchManager: MovieSearchManagerProtocol = MovieSearchManager()
    ) {
        self.viewController = viewController
        self.userDefaultsManager = userDefaultsManager
        self.movieSearchManager = movieSearchManager
    }
    
    func viewDidLoad() {
        viewController?.setupNavigationBar()
        viewController?.setupSearchBar()
        viewController?.setupView()
    }
    
    func viewWillAppear() {
        likedMovies = userDefaultsManager.getMovies().map { movie in
            var movie = movie
            movie.isLiked = true
            return movie
        }
        viewController?.updateCollectionView()
    }
}

extension MovieListPresenter: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        viewController?.updateSearchTableView(isHidden: false)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        currentMovieSearchResult = []
        viewController?.updateSearchTableView(isHidden: true)
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        movieSearchManager.request(from: searchText) { [weak self] movies in
            self?.currentMovieSearchResult = movies
            self?.viewController?.updateSearchTableView(isHidden: false)
        }
    }
}

extension MovieListPresenter: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return likedMovies.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: MovieListCollectionViewCell.identifier,
            for: indexPath
        ) as? MovieListCollectionViewCell else { return UICollectionViewCell() }
        
        let movie = likedMovies[indexPath.item]
        cell.update(movie)
        
        return cell
    }
}

extension MovieListPresenter: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let spacing: CGFloat = 16.0
        let width: CGFloat = (collectionView.frame.width - spacing * 3) / 2
        return CGSize(width: width, height: 210.0)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        let inset: CGFloat = 16.0
        return UIEdgeInsets(
            top: inset,
            left: inset,
            bottom: inset,
            right: inset
        )
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        let movie = likedMovies[indexPath.item]
        viewController?.pushToMovieDetailViewController(with: movie)
    }
}

extension MovieListPresenter: UITableViewDataSource {
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return currentMovieSearchResult.count
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "MovieListSearchResultTableViewCell")
        cell.textLabel?.text = currentMovieSearchResult[indexPath.row].title.htmlEscaped
        cell.detailTextLabel?.text = currentMovieSearchResult[indexPath.row].subtitle.htmlEscaped
        return cell
    }
}

extension MovieListPresenter: UITableViewDelegate {
    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        let movie = currentMovieSearchResult[indexPath.row]
        viewController?.pushToMovieDetailViewController(with: movie)
    }
}
