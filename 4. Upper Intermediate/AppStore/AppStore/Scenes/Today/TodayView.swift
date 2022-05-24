//
//  TodayView.swift
//  AppStore
//
//  Created by Sang hun Lee on 2022/05/23.
//

import UIKit

final class TodayView: UIView, ViewRepresentable {
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .systemBackground
        collectionView.register(
            TodayViewCell.self,
            forCellWithReuseIdentifier: TodayViewCell.identifier
        )
        collectionView.register(
            TodayViewHeader.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: TodayViewHeader.identifier
        )
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
        addSubview(collectionView)
    }
    
    func setupConstraints() {
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
