//
//  CardDetailView.swift
//  CreditCard
//
//  Created by Sang hun Lee on 2022/05/12.
//

import Foundation
import UIKit
import Lottie
import SnapKit

class CardDetailVeiw: UIView, ViewRepresentable {
    
    let verticalView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 20
        return stackView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "신용카드 쓰면\n0만원 드려요"
        label.textColor = .darkGray
        label.font = .systemFont(ofSize: 28, weight: .heavy)
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    let lottieView: AnimationView = {
        let view = AnimationView(name: "money")
        view.contentMode = .scaleAspectFit
        view.loopMode = .loop
        view.play()
        return view
    }()
    
    let periodHorizontalView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.spacing = 30
        return stackView
    }()
    
    let periodTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "참여 기간"
        label.font = .systemFont(ofSize: 17, weight: .bold)
        return label
    }()
    
    let periodDescLabel: UILabel = {
        let label = UILabel()
        label.text = "2021.1.11[월]~1.31[화]"
        return label
    }()
    
    let conditionHorizontalView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.spacing = 30
        return stackView
    }()
    
    let conditionTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "참여 조건"
        label.font = .systemFont(ofSize: 17, weight: .bold)
        return label
    }()
    
    let conditionDescLabel: UILabel = {
        let label = UILabel()
        label.text = "조건 없음"
        label.numberOfLines = 0
        return label
    }()
    
    let benefitConditionHorizontalView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.spacing = 30
        return stackView
    }()
    
    let benefitConditionTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "혜택 조건"
        label.font = .systemFont(ofSize: 17, weight: .bold)
        return label
    }()
    
    let benefitConditionDescLabel: UILabel = {
        let label = UILabel()
        label.text = "조건 없음"
        label.numberOfLines = 0
        return label
    }()
    
    let benefitDetailHorizontalView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.spacing = 30
        return stackView
    }()
    
    let benefitDetailTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "받는 혜택"
        label.font = .systemFont(ofSize: 17, weight: .bold)
        return label
    }()
    
    let benefitDetailDescLabel: UILabel = {
        let label = UILabel()
        label.text = "혜택 없음"
        label.numberOfLines = 0
        return label
    }()
    
    let benefitDateHorizontalView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.spacing = 30
        return stackView
    }()
    
    let benefitDateTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "받는 날짜"
        label.font = .systemFont(ofSize: 17, weight: .bold)
        return label
    }()
    
    let benefitDateDescLabel: UILabel = {
        let label = UILabel()
        label.text = "2021.1.11[월]"
        return label
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
        self.backgroundColor = .systemBackground
        verticalView.addArrangedSubview(titleLabel)
        verticalView.addArrangedSubview(lottieView)
        
        periodHorizontalView.addArrangedSubview(periodTitleLabel)
        periodHorizontalView.addArrangedSubview(periodDescLabel)
        verticalView.addArrangedSubview(periodHorizontalView)
        
        conditionHorizontalView.addArrangedSubview(conditionTitleLabel)
        conditionHorizontalView.addArrangedSubview(conditionDescLabel)
        verticalView.addArrangedSubview(conditionHorizontalView)
        
        benefitConditionHorizontalView.addArrangedSubview(benefitConditionTitleLabel)
        benefitConditionHorizontalView.addArrangedSubview(benefitConditionDescLabel)
        verticalView.addArrangedSubview(benefitConditionHorizontalView)
        
        benefitDetailHorizontalView.addArrangedSubview(benefitDetailTitleLabel)
        benefitDetailHorizontalView.addArrangedSubview(benefitDetailDescLabel)
        verticalView.addArrangedSubview(benefitDetailHorizontalView)
        
        benefitDateHorizontalView.addArrangedSubview(benefitDateTitleLabel)
        benefitDateHorizontalView.addArrangedSubview(benefitDateDescLabel)
        verticalView.addArrangedSubview(benefitDateHorizontalView)
    
        addSubview(verticalView)
    }
    
    func setupConstraints() {
        lottieView.snp.makeConstraints {
            $0.height.equalTo(200)
        }
        
        verticalView.snp.makeConstraints {
            $0.centerX.equalTo(safeAreaLayoutGuide)
            $0.centerY.equalTo(safeAreaLayoutGuide)
            $0.leading.equalTo(20)
            $0.trailing.equalTo(-20)
        }
        
        periodTitleLabel.setContentHuggingPriority(.init(rawValue: 1000), for: .horizontal)
    }
}
