//
//  MovieDetailViewController.swift
//  MovieRating
//
//  Created by Sang hun Lee on 2022/06/23.
//

import UIKit
import SnapKit
import Kingfisher

final class MovieDetailViewController: UIViewController {
    private var presenter: MovieDetailPresenter!
    private lazy var rightBarButtonItem = UIBarButtonItem(
        image: nil,
        style: .plain,
        target: self,
        action: #selector(didTapRightBarButtonItem)
    )
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .secondarySystemBackground
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
    
    init(movie: Movie) {
        super.init(nibName: nil, bundle: nil)
        presenter = MovieDetailPresenter(viewController: self, movie: movie)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MovieDetailViewController: MovieDetailProtocol {
    func setupView(with movie: Movie) {
        view.backgroundColor = .systemBackground
        
        navigationItem.title = movie.title.htmlEscaped
        navigationItem.rightBarButtonItem = rightBarButtonItem
        
        let subTitleContentsStackView = MovieDetailContentsStackView(title: "부제", contents: movie.subtitle.htmlEscaped)
        let userRatingContentsStackView = MovieDetailContentsStackView(title: "평점", contents: movie.userRating)
        let actorContentsStackView = MovieDetailContentsStackView(title: "배우", contents: movie.actor)
        let directorContentsStackView = MovieDetailContentsStackView(title: "감독", contents: movie.director)
        let pubDateContentsStackView = MovieDetailContentsStackView(title: "제작년도", contents: movie.pubDate)
        
        let contentsStackView = UIStackView()
        contentsStackView.axis = .vertical
        contentsStackView.spacing = 8.0
        
        [
            subTitleContentsStackView,
            userRatingContentsStackView,
            actorContentsStackView,
            directorContentsStackView,
            pubDateContentsStackView
        ].forEach {
            contentsStackView.addArrangedSubview($0)
        }
        
        [imageView, contentsStackView].forEach {
            view.addSubview($0)
        }
        
        let inset: CGFloat = 16.0
        
        imageView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.topMargin).inset(inset)
            $0.leading.equalToSuperview().inset(inset)
            $0.trailing.equalToSuperview().inset(inset)
            $0.height.equalTo(imageView.snp.width)
        }
        
        contentsStackView.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(inset)
            $0.leading.trailing.equalTo(imageView)
        }
        
        if let imageURL = movie.imageURL {
            imageView.kf.setImage(with: imageURL)
        }
    }
    
    func setRightBarButton(with isLiked: Bool) {
        let imageName = isLiked ? "star.fill" : "star"
        rightBarButtonItem.image = UIImage(systemName: imageName)
    }
}

private extension MovieDetailViewController {
    @objc func didTapRightBarButtonItem() {
        presenter.didTapRightBarButtonItem()
    }
}
