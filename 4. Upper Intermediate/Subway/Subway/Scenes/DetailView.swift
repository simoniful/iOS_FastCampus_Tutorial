//
//  DetailView.swift
//  Subway
//
//  Created by Sang hun Lee on 2022/05/27.
//

import UIKit
import SnapKit

class DetailView: UIView, ViewRepresentable {

    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = CGSize(width: UIScreen.main.bounds.size.width - 32.0, height: 100.0)
        layout.sectionInset = UIEdgeInsets(top: 16.0, left: 16.0, bottom: 16.0, right: 16.0)
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .systemBackground
        collectionView.register(DetailViewCell.self, forCellWithReuseIdentifier: DetailViewCell.identifier)

        return collectionView
    }()
    
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError()
    }
    
    func setupView() {
        self.addSubview(collectionView)
    }
    
    func setupConstraints() {
        collectionView.snp.makeConstraints {
            $0.edges.equalTo(safeAreaLayoutGuide)
        }
    }
}
