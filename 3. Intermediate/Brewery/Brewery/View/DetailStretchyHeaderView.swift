//
//  DetailStretchyHeaderView.swift
//  Brewery
//
//  Created by Sang hun Lee on 2022/05/31.
//

import UIKit
import SnapKit

final class DetailStretchyHeaderView: UIView, ViewRepresentable {
   
    private var containerView = DetailHeaderDescriptionView()
    
    public let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        addSubview(imageView)
        addSubview(containerView)
    }
    
    func setupConstraints() {
        imageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(8)
            make.height.equalToSuperview().multipliedBy(0.5)
            make.width.equalTo(snp.height).multipliedBy(0.5)
        }
        
        containerView.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(-60)
            make.centerX.equalToSuperview()
            make.leading.trailing.bottom.equalToSuperview().inset(8)
        }
        
        containerView.isUserInteractionEnabled = true
    }
    
    public func scrollViewDidScroll(scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.y
        if offset < 0 {
            imageView.snp.updateConstraints {
                $0.height.equalToSuperview().multipliedBy(0.5).offset(-offset)
            }
        }
    }
}
