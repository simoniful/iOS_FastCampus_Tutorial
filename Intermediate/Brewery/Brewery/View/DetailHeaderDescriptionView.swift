//
//  DetailHeaderDescriptionView.swift
//  Brewery
//
//  Created by Sang hun Lee on 2022/05/31.
//

import UIKit
import SnapKit

class DetailHeaderDescriptionView: UIView {
    
    var moreHandler: ((_ isExpended: Bool) -> ())?
    
    private let descriptionView: UIView = {
        let uiView = UIView()
        uiView.layer.cornerRadius = 8
        uiView.backgroundColor = .white
        return uiView
    }()
    
    private var isExpended = false
    
    private let titlelabel = UILabel()
    private let originLabel = UILabel()
    private let descriptionTextView = UITextView()
    
    public let moreButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .bold)
        button.setTitle("more", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.setTitleColor(.black.withAlphaComponent(0.5), for: .highlighted)
        return button
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.alignment = .center
        stackView.distribution = .fillProportionally
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        descriptionViewConfigure()
        isUserInteractionEnabled = true
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func beerConfigure(beer: Beer) {
        print(#function)
        titlelabel.text = beer.name
        originLabel.text = beer.tagline
        descriptionTextView.text = beer.description
    }
    
    private func descriptionViewConfigure() {
        addSubview(descriptionView)
        descriptionView.layer.shadowRadius = 2
        descriptionView.layer.shadowOffset = .init(width: 1, height: 1)
        descriptionView.layer.shadowOpacity = 0.4
        
        descriptionView.addSubview(stackView)
        descriptionView.addSubview(titlelabel)
        descriptionView.addSubview(originLabel)
        descriptionView.addSubview(descriptionTextView)
        addSubview(moreButton)
        
        descriptionTextView.isEditable = false
        descriptionTextView.showsVerticalScrollIndicator = false
        descriptionTextView.textColor = .black
        
        descriptionView.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.9)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        titlelabel.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.9)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(8)
        }
        
        originLabel.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.9)
            make.centerX.equalToSuperview()
            make.top.equalTo(titlelabel.snp.bottom).offset(16)
        }
        
        descriptionTextView.snp.makeConstraints { make in
            make.top.equalTo(originLabel.snp.bottom).offset(8)
            make.width.equalToSuperview()
            make.centerX.equalToSuperview()
            make.bottom.equalTo(moreButton.snp.top).offset(-8)
        }
        
        moreButton.snp.makeConstraints { make in
            make.height.equalTo(22)
            make.width.equalToSuperview().multipliedBy(0.9)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(8)
        }
        
        
        moreButton.addTarget(self, action: #selector(descriptionExpend(_:)), for: .touchUpInside)
        
        titlelabel.textAlignment = .center
        titlelabel.font = .systemFont(ofSize: 22, weight: .bold)
        titlelabel.textColor = .black
        
        originLabel.textAlignment = .center
        originLabel.font = .systemFont(ofSize: 14)
        
        descriptionTextView.font = .systemFont(ofSize: 15)
    }
    
    @objc private func descriptionExpend(_ sender: UIButton) {
        isExpended.toggle()
        UIView.transition(with: stackView, duration: 0.2, options: .transitionCrossDissolve) {
            
        } completion: { _ in
            self.moreHandler?(self.isExpended)
        }
        
        
    }
}
