//
//  ViewController.swift
//  WaterDrink
//
//  Created by Sang hun Lee on 2022/05/14.
//

import UIKit
import UserNotifications

class AlertListViewController: UIViewController {
    let alertListView = AlertListView()
    var alerts: [Alert] = []
    let userNotificationCenter = UNUserNotificationCenter.current()
    
    override func loadView() {
        super.loadView()
        self.view = alertListView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigation()
        alertListView.tableView.delegate = self
        alertListView.tableView.dataSource = self
        alertListView.tableView.register(AlertListViewCell.self, forCellReuseIdentifier: AlertListViewCell.identifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.alerts = alertList()
    }
    
    func setNavigation() {
        self.title = "물 마시기"
        let additionBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .done, target: self, action: #selector(additionBarButtonTapped))
        self.navigationItem.rightBarButtonItem  = additionBarButtonItem
    }
    
    @objc func additionBarButtonTapped() {
        let addAlertViewController = AddAlertViewController()
        addAlertViewController.pickedDate = { [weak self] date in
            guard let self = self else { return }
            var alertList = self.alertList()
            let newAlert = Alert(date: date, isOn: true)
            
            alertList.append(newAlert)
            alertList.sort { $0.date < $1.date }
            
            self.alerts = alertList
            
            UserDefaults.standard.set(try? PropertyListEncoder().encode(self.alerts), forKey: "alerts")
            self.userNotificationCenter.addNotificationRequest(by: newAlert)
            
            self.alertListView.tableView.reloadData()
        }
        
        self.present(addAlertViewController, animated: true, completion: nil)
    }
    
    func alertList() -> [Alert] {
        // UserDefaults의 제한된 타입 이해(Bool, String..)
        // 디코딩 필수
        guard let data = UserDefaults.standard.value(forKey: "alerts") as? Data,
              let alerts = try? PropertyListDecoder().decode([Alert].self, from: data) else { return [] }
        return alerts
    }
}

extension AlertListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return alerts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AlertListViewCell.identifier, for: indexPath) as? AlertListViewCell else { return UITableViewCell() }
        
        cell.meridiemLabel.text = alerts[indexPath.row].meridiem
        cell.timeLabel.text = alerts[indexPath.row].time
        cell.onOffSwitch.isOn = alerts[indexPath.row].isOn
        
        cell.onOffSwitch.tag = indexPath.row
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "🚰 물마실 시간"
        default:
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            // 노티피케이션 삭제 구현
            // 테이블 뷰 배열과 내부 저장소 상태를 동기화
            userNotificationCenter.removePendingNotificationRequests(withIdentifiers: [alerts[indexPath.row].id])
            self.alerts.remove(at: indexPath.row)
            UserDefaults.standard.set(try? PropertyListEncoder().encode(self.alerts), forKey: "alerts")
            self.alertListView.tableView.reloadData()
            return
        default:
            break
        }
    }
}

