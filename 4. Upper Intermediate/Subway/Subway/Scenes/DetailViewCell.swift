//
//  DetailViewCell.swift
//  Subway
//
//  Created by Sang hun Lee on 2022/05/27.
//

import UIKit

final class DetailViewCell: UICollectionViewCell, ViewRepresentable {
    static let identifier = "DetailViewCell"
    
    lazy var lineLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15.0, weight: .bold)
        label.text = "한양대 방면"
        return label
    }()
    
    lazy var remainTimeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15.0, weight: .medium)
        label.text = "뚝섬 도착"
        return label
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupView()
        setupConstraints()
    }
    
    func setupView() {
        [lineLabel, remainTimeLabel].forEach {
            addSubview($0)
        }
        backgroundColor = .systemBackground
        layer.cornerRadius = 12.0
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowRadius = 10
    }
    
    func setupConstraints() {
        lineLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.top.equalToSuperview().inset(16)
        }
        
        remainTimeLabel.snp.makeConstraints {
            $0.leading.equalTo(lineLabel)
            $0.top.equalTo(lineLabel.snp.bottom).offset(16)
            $0.bottom.equalToSuperview().inset(16)
        }
    }
    
    func configureCell(with realtimeArrival: RealtimeArrivalList) {
        lineLabel.text = realtimeArrival.trainLineNm
        remainTimeLabel.text = realtimeArrival.arvlMsg2
    }
}
