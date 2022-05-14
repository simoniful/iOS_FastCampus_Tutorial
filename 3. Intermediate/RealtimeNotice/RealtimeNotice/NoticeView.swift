//
//  NoticeView.swift
//  RealtimeNotice
//
//  Created by Sang hun Lee on 2022/05/13.
//

import Foundation
import UIKit
import SnapKit

class NoticeView: UIView, ViewRepresentable {
    let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.layer.cornerRadius = 6
        return view
    }()
    
    let verticalView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.alignment = .fill
        stackView.spacing = 10
        return stackView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "공지사항"
        label.textAlignment = .center
        return label
    }()
    
    let subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "안내드립니다"
        label.textAlignment = .center
        label.font = .preferredFont(forTextStyle: .largeTitle)
        label.numberOfLines = 2
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        
        return label
    }()
    
    let descLabel: UILabel = {
        let label = UILabel()
        label.text = "서비스 이용에 참고 부탁드립니다"
        label.textAlignment = .center
        label.font = .preferredFont(forTextStyle: .body)
        label.numberOfLines = 4
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        return label
    }()
    
    let termTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "점검 일시"
        label.font = .systemFont(ofSize: 15, weight: .bold)
        label.textAlignment = .left
        return label
    }()
    
    let termDescLabel: UILabel = {
        let label = UILabel()
        label.text = "2022년 5월 13일(월) 00:00~03:00(3시간)"
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        return label
    }()
    
    let closeButton: UIButton = {
        let button = UIButton()
        button.setTitle("확인", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = .preferredFont(forTextStyle: .title3)
        button.backgroundColor = .systemGray5
        return button
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
        self.backgroundColor = .black.withAlphaComponent(0.5)
        addSubview(containerView)
        verticalView.addArrangedSubview(titleLabel)
        verticalView.addArrangedSubview(subtitleLabel)
        verticalView.addArrangedSubview(descLabel)
        verticalView.addArrangedSubview(termTitleLabel)
        verticalView.addArrangedSubview(termDescLabel)
        verticalView.addArrangedSubview(closeButton)
        containerView.addSubview(verticalView)
    }
    
    func setupConstraints() {
        containerView.snp.makeConstraints {
            $0.centerX.equalTo(safeAreaLayoutGuide)
            $0.centerY.equalTo(safeAreaLayoutGuide)
            $0.width.equalTo(300)
            $0.height.equalTo(400)
        }
        
        verticalView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.bottom.equalToSuperview().offset(-20)
        }
        
        closeButton.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.height.equalTo(60)
        }
    }
}
