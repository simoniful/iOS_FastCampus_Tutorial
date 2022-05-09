//
//  MainView.swift
//  Covid-19
//
//  Created by Sang hun Lee on 2022/05/07.
//

import Foundation
import UIKit
import SnapKit
import Charts

class MainView: UIView, ViewRepresentable {
    let activityIndicator : UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        return indicator
    }()
    
    let localTitleLabel : UILabel = {
        let label = UILabel()
        label.text = "국내 확진자"
        return label
    }()
    
    let localCountLabel : UILabel = {
        let label = UILabel()
        return label
    }()
    
    let verticalStackView1: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.spacing = 20
        return stackView
    }()
    
    let localNewTitleLabel : UILabel = {
        let label = UILabel()
        label.text = "국내 신규 확진자"
        return label
    }()
    
    let localNewCountLabel : UILabel = {
        let label = UILabel()
        return label
    }()
    
    let verticalStackView2: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.spacing = 20
        return stackView
    }()
    
    let horizontalStackView1: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 0
        stackView.alignment = .center
        stackView.isHidden = true
        return stackView
    }()
    
    let pieChart: PieChartView = {
        let pieChart = PieChartView()
        pieChart.isHidden = true
        return pieChart
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
        verticalStackView1.addArrangedSubview(localTitleLabel)
        verticalStackView1.addArrangedSubview(localCountLabel)
        
        verticalStackView2.addArrangedSubview(localNewTitleLabel)
        verticalStackView2.addArrangedSubview(localNewCountLabel)
        
        horizontalStackView1.addArrangedSubview(verticalStackView1)
        horizontalStackView1.addArrangedSubview(verticalStackView2)
        
        addSubview(horizontalStackView1)
        addSubview(pieChart)
        addSubview(activityIndicator)
    }
    
    func setupConstraints() {
        horizontalStackView1.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).offset(24)
            $0.leading.equalTo(24)
            $0.trailing.equalTo(-24)
        }
        
        pieChart.snp.makeConstraints {
            $0.top.equalTo(horizontalStackView1.snp.bottom).offset(24)
            $0.leading.equalTo(24)
            $0.trailing.equalTo(-24)
            $0.bottom.equalTo(-24)
        }
        
        activityIndicator.snp.makeConstraints {
            $0.centerX.equalTo(safeAreaLayoutGuide)
            $0.centerY.equalTo(safeAreaLayoutGuide)
        }
    }
}
