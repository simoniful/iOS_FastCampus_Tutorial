//
//  ViewController.swift
//  CreditCard
//
//  Created by Sang hun Lee on 2022/05/12.
//

import UIKit
import Kingfisher
import SnapKit
import FirebaseDatabase
import FirebaseFirestore

class CardListViewController: UIViewController {
    let tableView = UITableView()
    
    // Firebase realtime Database ref
    // var ref: DatabaseReference!
    
    // Firestore 객체 생성
    var db = Firestore.firestore()

    var creditCardList: [CreditCard] = []
    
    override func loadView() {
        super.loadView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "카드 혜택 추천"
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(CardListViewCell.self, forCellReuseIdentifier: CardListViewCell.identifier)
        setTableView()
        // bindToDB()
        bindToFirestore()
    }
    
    func setTableView() {
        self.view.addSubview(tableView)
        self.tableView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
    // 실시간 DB 읽기 코드
//    func bindToDB() {
//        ref = Database.database().reference()
//        ref.observe(.value) { snapshot in
//            guard let value = snapshot.value as? [String: [String: Any]] else { return }
//
//            do {
//                let jsonData = try JSONSerialization.data(withJSONObject: value)
//                let cardData = try JSONDecoder().decode([String: CreditCard].self, from: jsonData)
//                let cardList = Array(cardData.values)
//                self.creditCardList = cardList.sorted{ $0.rank < $1.rank }
//
//                DispatchQueue.main.async {
//                    self.tableView.reloadData()
//                }
//            } catch let error {
//                print("ERROR JSON Parsing \(error.localizedDescription)")
//            }
//        }
//    }
    
    // Firestore 읽기 코드
    func bindToFirestore() {
        db.collection("creditCardList").addSnapshotListener { snapshot, error in
            guard let documents = snapshot?.documents else {
                print("ERROR Firestore fetching document \(String(describing: error?.localizedDescription))")
                return
            }
            
            self.creditCardList = documents.compactMap{ doc -> CreditCard? in
                do {
                    let jsonData = try JSONSerialization.data(withJSONObject: doc.data(), options: [])
                    let creditCard = try JSONDecoder().decode(CreditCard.self, from: jsonData)
                    return creditCard
                } catch let error {
                    print("ERROR JSON Parsing \(error.localizedDescription)")
                    return nil
                }
            }.sorted{ $0.rank < $1.rank }
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}

extension CardListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return creditCardList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CardListViewCell.identifier, for: indexPath) as? CardListViewCell else { return UITableViewCell() }
        
        let imageURL = URL(string: creditCardList[indexPath.row].cardImageURL)
        
        cell.cardImageView.kf.setImage(with: imageURL)
        
        cell.rankLabel.text = "\(creditCardList[indexPath.row].rank)위"
        cell.benefitLabel.text = "\(creditCardList[indexPath.row].promotionDetail.amount)만원 증정"
        cell.cardTitleLabel.text = "\(creditCardList[indexPath.row].name)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailViewController = CardDetailViewController()
        detailViewController.promotionDetail = creditCardList[indexPath.row].promotionDetail
        self.show(detailViewController, sender: nil)
        
        // DB의 데이터 구조에 따라 객체가 생성될 때 마다 임의의 문자열 조합으로 저장하기도 함
        // 서로 다른 데이터가 짧은 시간 내 여러개 생성될 경우 아이디 중복을 막기 위해서 구조화
        // 지정해준 거처럼 어떤 아이디로 생성될지 알 수 없기 때문에 생성된 다음에야 확인 가능
        // 따라서 코드 작성 시점에는 해당 객체가 어떤 ID 값을 가질지 모름
        // 객체의 키는 알 수 없지만 고유한 값을 기반으로 검색 가능 - 쿼리
        
        let cardID = creditCardList[indexPath.row].id
        
        // 실시간 DB 쓰기
        // 쓰기 Option 1
//        ref.child("Item\(cardID)/isSelected").setValue(true)
        
        // 쓰기 Option 2 - Query Order, 값을 추출해서 검색 후 해당 부분 업데이트
//        ref.queryOrdered(byChild: "id").queryEqual(toValue: cardID).observe(.value) { [weak self] snapshot in
//            guard let self = self,
//                  let value = snapshot.value as? [String: [String: Any]],
//                  let key = value.keys.first else { return }
//            self.ref.child("\(key)/isSelected").setValue(true)
//        }
        
        // Firestore 쓰기
        // Option1 - 경로를 알고 있을 때, id를 아는 경우
//        db.collection("creditCardList").document("card\(cardID)").updateData(["isSelected": true])
        
        // Option2 - 경로를 모를 때, 고유 값 기준 검색
        db.collection("creditCardList")
            .whereField("id", isEqualTo: cardID)
            .getDocuments { snapshot, error in
                // 도큐먼트는 배열로 전달(sort)
                guard let document = snapshot?.documents.first else {
                    print("ERROR Firestore fetching document: \(error?.localizedDescription)")
                    return
                }
                document.reference.updateData(["isSelected": true])
            }
        
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            let cardID = creditCardList[indexPath.row].id
              // 실시간 데이터 베이스 삭제
//            // 삭제 Option 1
//            ref.child("Item\(cardID)").removeValue()
//
//            // 삭제 Option 2 - 검색 후 삭제
//            ref.queryOrdered(byChild: "id").queryEqual(toValue: cardID).observe(.value) { [weak self] snapshot in
//                guard let self = self,
//                      let value = snapshot.value as? [String: [String: Any]],
//                      let key = value.keys.first else { return }
//                self.ref.child(key).removeValue()
//            }
            
            // Firestore 삭제
            // Option 1 - 경로를 알 때
//            db.collection("creditCardList")
//                .document("card\(cardID)")
//                .delete()
            
            // Option 2 - 경로를 모를 때
            db.collection("creditCardList")
                .whereField("id", isEqualTo: cardID)
                .getDocuments { snapshot, error in
                    guard let document = snapshot?.documents.first else {
                        print("ERROR Firestore fetching document: \(error?.localizedDescription)")
                        return
                    }
                    document.reference.delete()
                }
            
            
        }
    }
}

