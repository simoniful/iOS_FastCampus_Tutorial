//
//  CardDetailViewController.swift
//  CreditCard
//
//  Created by Sang hun Lee on 2022/05/12.
//

import UIKit
import Lottie
import SnapKit

class CardDetailViewController: UIViewController {
    let cardDetailView = CardDetailVeiw()
    var promotionDetail: PromotionDetail?
    
    override func loadView() {
        self.view = cardDetailView
        setLottieAnimation()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "카드 혜택 상세"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let detail = promotionDetail else { return }
        cardDetailView.titleLabel.text = """
            \(detail.companyName)카드 쓰면
            \(detail.amount)만원 드려요
        """
        cardDetailView.periodDescLabel.text = "\(detail.period)"
        cardDetailView.conditionDescLabel.text = "\(detail.condition)"
        cardDetailView.benefitConditionDescLabel.text = "\(detail.benefitCondition)"
        cardDetailView.benefitDetailDescLabel.text = "\(detail.benefitDetail)"
        cardDetailView.benefitDateDescLabel.text = "\(detail.benefitDate)"
    }
    
    func setLottieAnimation() {
        let animationView = AnimationView(name: "money")
        // animationView.frame = self.cardDetailView.lottieView.bounds
        // animationView.center = self.cardDetailView.lottieView.center
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.play()
        self.cardDetailView.lottieView.addSubview(animationView)
        animationView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
            $0.width.equalTo(200)
            $0.height.equalTo(200)
        }
    }
}
