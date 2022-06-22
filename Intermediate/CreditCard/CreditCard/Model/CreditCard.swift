//
//  CreditCard.swift
//  CreditCard
//
//  Created by Sang hun Lee on 2022/05/12.
//

import Foundation

struct CreditCard: Codable {
    var id: Int
    var rank: Int
    var name: String
    var cardImageURL: String
    var promotionDetail: PromotionDetail
    var isSelected: Bool?
}

struct PromotionDetail: Codable {
    var companyName: String
    var period: String
    var amount: Int
    var condition, benefitCondition, benefitDetail, benefitDate: String
}
