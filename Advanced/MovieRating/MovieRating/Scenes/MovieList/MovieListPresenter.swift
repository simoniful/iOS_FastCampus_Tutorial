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
}

final class MovieListPresenter: NSObject {
    // unowned let / weak var
    private weak var viewController: MovieListProtocol?
    
    private let movieSearchManager: MovieSearchManagerProtocol
    
    private var likedMovies: [Movie] = [
        Movie(
            title: "스타워즈: 라스트 제다이",
            link:  "https://movie.naver.com/movie/bi/mi/basic.nhn?code=125488",
            image:  "https://ssl.pstatic.net/imgmovie/mdi/mit110/1254/125488_P20_135324.jpg",
            subtitle: "<b>Star</b> <b>Wars</b>: The Last Jedi",
            pubDate: "2017",
            director: "라이언 존슨|",
            actor: "데이지 리들리|마크 해밀|오스카 아이삭|아담 드라이버|캐리 피셔|존 보예가|",
            userRating: "6.33"
        ),
        Movie(
            title: "스타워즈: 라스트 제다이",
            link:  "https://movie.naver.com/movie/bi/mi/basic.nhn?code=125488",
            image:  "https://ssl.pstatic.net/imgmovie/mdi/mit110/1254/125488_P20_135324.jpg",
            subtitle: "<b>Star</b> <b>Wars</b>: The Last Jedi",
            pubDate: "2017",
            director: "라이언 존슨|",
            actor: "데이지 리들리|마크 해밀|오스카 아이삭|아담 드라이버|캐리 피셔|존 보예가|",
            userRating: "6.33"
        ),
        Movie(
            title: "스타워즈: 라스트 제다이",
            link:  "https://movie.naver.com/movie/bi/mi/basic.nhn?code=125488",
            image:  "https://ssl.pstatic.net/imgmovie/mdi/mit110/1254/125488_P20_135324.jpg",
            subtitle: "<b>Star</b> <b>Wars</b>: The Last Jedi",
            pubDate: "2017",
            director: "라이언 존슨|",
            actor: "데이지 리들리|마크 해밀|오스카 아이삭|아담 드라이버|캐리 피셔|존 보예가|",
            userRating: "6.33"
        )
    ]
    
    private var currentMovieSearchResult: [Movie] = []
    
    init(viewController: MovieListProtocol, movieSearchManager: MovieSearchManagerProtocol = MovieSearchManager()) {
        self.viewController = viewController
        self.movieSearchManager = movieSearchManager
    }
    
    func viewDidLoad() {
        viewController?.setupNavigationBar()
        viewController?.setupSearchBar()
        viewController?.setupView()
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
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return likedMovies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
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
}

extension MovieListPresenter: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentMovieSearchResult.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "MovieListSearchResultTableViewCell")
        cell.textLabel?.text = currentMovieSearchResult[indexPath.row].title.htmlEscaped
        cell.detailTextLabel?.text = currentMovieSearchResult[indexPath.row].subtitle.htmlEscaped
        return cell
    }
}

extension MovieListPresenter: UITableViewDelegate {
    
}
