//
//  CreditCard.swift
//  CreditCard
//
//  Created by Sang hun Lee on 2022/05/12.
//

import Foundation

struct CreditCard: Codable {
    var cardImageURL: String
    var id, rank: Int
    var name: String
    var promotionDetail: PromotionDetail
    var isSelected: Bool?
}

struct PromotionDetail: Codable {
    var companyName: String
    var amount: Int
    var period, benefitDate, benefitDetail, benefitCondition, condition: String
}
