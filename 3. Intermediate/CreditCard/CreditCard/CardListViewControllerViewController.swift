//
//  ViewController.swift
//  CreditCard
//
//  Created by Sang hun Lee on 2022/05/12.
//

import UIKit
import Kingfisher

class CardListViewController: UITableViewController {
    let creditCardListView = CardListView()
    
    let API_KEY = Bundle.main.object(forInfoDictionaryKey: "API_KEY") as? String
    
    var creditCardList: [CreditCard] = []
    
    override func loadView() {
        self.view = creditCardListView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "카드 혜택 추천"
        creditCardListView.register(CardListViewCell.self, forCellReuseIdentifier: CardListViewCell.identifier)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return creditCardList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CardListViewCell.identifier, for: indexPath) as? CardListViewCell else { return UITableViewCell() }
        
        let imageURL = URL(string: creditCardList[indexPath.row].cardImageURL)
        
        cell.cardImageView.kf.setImage(with: imageURL)
        
        cell.rankLabel.text = "\(creditCardList[indexPath.row].rank)위"
        cell.benefitLabel.text = "\(creditCardList[indexPath.row].promotionDetail.amount)만원 증정"
        cell.cardTitleLabel.text = "\(creditCardList[indexPath.row].name)"
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailViewController = CardDetailViewController()
        detailViewController.promotionDetail = creditCardList[indexPath.row].promotionDetail
        self.show(detailViewController, sender: nil)
    }
}

