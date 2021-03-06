//
//  RankingSectionView.swift
//  AppStore
//
//  Created by Sang hun Lee on 2022/05/24.
//

import UIKit
import SnapKit

final class RankingSectionView: UIView, ViewRepresentable {
    private var rankingList: [Ranking]  = []
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .black)
        label.text = "iPhone이 처음이라면"
        return label
    }()
    
    private lazy var showAllAppsButton: UIButton = {
        let button = UIButton()
        button.setTitle("모두 보기", for: .normal)
        button.setTitleColor(UIColor.systemBlue, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .semibold)
        return button
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 32.0
        layout.minimumInteritemSpacing = 0.0
        layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.isPagingEnabled = true
        collectionView.backgroundColor = .systemBackground
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(RankingSectionViewCell.self, forCellWithReuseIdentifier: RankingSectionViewCell.identifier)
        
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
        fetchData()
        collectionView.reloadData()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError()
    }
    
    private let seperatorView = SeperatorView(frame: .zero)
    
    func setupView() {
        [titleLabel, showAllAppsButton, collectionView, seperatorView].forEach {
            addSubview($0)
        }
    }
    
    func setupConstraints() {
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(24)
            $0.leading.equalToSuperview().inset(16)
            $0.trailing.equalTo(showAllAppsButton.snp.leading).offset(8)
        }
        
        showAllAppsButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(16)
            $0.centerY.equalTo(titleLabel.snp.centerY)
        }
        
        // 한 화면에서 최대 표시될 부분 구성
        collectionView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(16)
            $0.height.equalTo(RankingSectionViewCell.height * 3)
            $0.leading.trailing.equalToSuperview()
        }
        
        seperatorView.snp.makeConstraints {
            $0.top.equalTo(collectionView.snp.bottom).offset(16)
            $0.leading.bottom.trailing.equalToSuperview()
            $0.height.equalTo(0.5)
        }
    }
}

private extension RankingSectionView {
    func fetchData() {
        guard let url = Bundle.main.url(forResource: "Ranking", withExtension: "plist") else { return }
        do {
            let data = try Data(contentsOf: url)
            let result = try PropertyListDecoder().decode([Ranking].self, from: data)
            rankingList = result
        } catch {
            fatalError("ERROR: Local plist file fetching failed")
        }
    }
}

extension RankingSectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return rankingList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RankingSectionViewCell.identifier, for: indexPath) as? RankingSectionViewCell else { return UICollectionViewCell() }
        cell.configureCell(ranking: rankingList[indexPath.item])
        return cell
    }
}

extension RankingSectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - 32.0, height: RankingSectionViewCell.height)
    }
}
