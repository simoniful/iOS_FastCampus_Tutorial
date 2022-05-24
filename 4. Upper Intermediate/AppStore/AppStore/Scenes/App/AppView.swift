//
//  AppView.swift
//  AppStore
//
//  Created by Sang hun Lee on 2022/05/23.
//

import UIKit
import SnapKit

final class AppView: UIView, ViewRepresentable {
    
    let scrollView = UIScrollView()
    
    let contentView = UIView()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 0
        return stackView
    
    }()
    
    let featureSectionView = FeatureSectionView(frame: .zero)
    let rankingSectionView = RankingSectionView(frame: .zero)
    let exchangeCodeSectionView = ExchangeCodeSectionView(frame: .zero)
    let spacingView = UIView()
    
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
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(stackView)
        
        [featureSectionView, rankingSectionView, exchangeCodeSectionView, spacingView].forEach {
            stackView.addArrangedSubview($0)
        }
    }
    
    func setupConstraints() {
        scrollView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            // 너비를 설정하면 세로 스크롤만 가능
            // 높이를 설정하면 가로 스크롤만 가능
            $0.width.equalToSuperview()
        }
        
        stackView.snp.makeConstraints {
            // 높이는 컨텐츠 크기에 맞게 추가되므로 지정X
            $0.edges.equalToSuperview()
        }
        
        spacingView.snp.makeConstraints {
            $0.height.equalTo(60)
        }
    }
    
    
}
