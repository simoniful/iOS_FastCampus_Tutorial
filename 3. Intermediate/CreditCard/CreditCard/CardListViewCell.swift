//
//  CardListViewCell.swift
//  CreditCard
//
//  Created by Sang hun Lee on 2022/05/12.
//

import UIKit
import SnapKit

class CardListViewCell: UITableViewCell, ViewRepresentable {
    static let identifier = "CardListViewCell"
    
    let horizontalView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.spacing = 0
        return stackView
    }()
    
    let cardImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "creditcard.fill")
        return imageView
    }()
    
    let verticalView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .leading
        stackView.spacing = 0
        return stackView
    }()
    
    let horizontalView2: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.alignment = .center
        stackView.spacing = 0
        return stackView
    }()
    
    let rankLabel: UILabel = {
        let label = UILabel()
        label.text = "0위"
        label.font = .systemFont(ofSize: 19, weight: .bold)
        return label
    }()
    
    let benefitLabel: UILabel = {
        let label = UILabel()
        label.text = "0만원 증정"
        label.textColor = .white
        label.font = .systemFont(ofSize: 12, weight: .bold)
        label.backgroundColor = .lightGray
        label.textAlignment = .center
        return label
    }()
    
    let cardTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "신용카드"
        label.font = .systemFont(ofSize: 19, weight: .bold)
        return label
    }()
    
    let arrowImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "chevron.right")
        return imageView
    }()
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.isUserInteractionEnabled = true
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func setupView() {
        horizontalView.addArrangedSubview(cardImageView)
        horizontalView2.addArrangedSubview(rankLabel)
        horizontalView2.addArrangedSubview(benefitLabel)
        verticalView.addArrangedSubview(horizontalView2)
        verticalView.addArrangedSubview(cardTitleLabel)
        horizontalView.addArrangedSubview(verticalView)
        horizontalView.addArrangedSubview(arrowImage)
        addSubview(horizontalView)
    }
    
    func setupConstraints() {
        cardImageView.snp.makeConstraints {
            $0.width.equalTo(80)
            $0.height.equalTo(40)
        }
        
        horizontalView.snp.makeConstraints {
            $0.centerY.equalTo(safeAreaLayoutGuide)
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-10)
            $0.bottom.equalToSuperview()
        }
        
        benefitLabel.snp.makeConstraints {
            $0.width.equalTo(80)
            $0.height.equalTo(20)
        }
        
        arrowImage.snp.makeConstraints {
            $0.width.equalTo(20)
            $0.height.equalTo(20)
        }
    }
}
