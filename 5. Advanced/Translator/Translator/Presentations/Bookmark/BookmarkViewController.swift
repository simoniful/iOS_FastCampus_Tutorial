//
//  BookmarkViewController.swift
//  Translator
//
//  Created by Sang hun Lee on 2022/06/17.
//

import SnapKit
import UIKit

final class BookmarkViewController: UIViewController {
    private var bookmarks: [Bookmark] = []
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let inset: CGFloat = 16.0
        
        layout.estimatedItemSize = CGSize(width: view.frame.width - (inset * 2), height: 100.0)
        layout.sectionInset = UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
        layout.minimumLineSpacing = inset
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .secondarySystemBackground
        collectionView.register(BookmarkCell.self, forCellWithReuseIdentifier: BookmarkCell.identifier)
        collectionView.dataSource = self
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        setupNavigation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        bookmarks = UserDefaults.standard.bookmarks
        collectionView.reloadData()
    }
}

private extension BookmarkViewController {
    func setupNavigation() {
        navigationItem.title = "즐겨찾기"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func setupLayout() {
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

extension BookmarkViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bookmarks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BookmarkCell.identifier, for: indexPath) as? BookmarkCell else { return UICollectionViewCell() }
        let bookmark = bookmarks[indexPath.item]
        cell.configureCell(from: bookmark)
        return cell
    }
}


