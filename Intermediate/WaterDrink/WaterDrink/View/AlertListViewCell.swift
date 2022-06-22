//
//  AlertListViewCell.swift
//  WaterDrink
//
//  Created by Sang hun Lee on 2022/05/14.
//

import UIKit
import UserNotifications

class AlertListViewCell: UITableViewCell, ViewRepresentable {
    static let identifier = "AlertListViewCell"
    let userNotificationCenter = UNUserNotificationCenter.current()
    
    let meridiemLabel: UILabel = {
        let label = UILabel()
        label.text = "오전"
        label.font = .systemFont(ofSize: 25, weight: .light)
        return label
    }()
    
    let timeLabel: UILabel = {
        let label = UILabel()
        label.text = "00:00"
        label.font = .systemFont(ofSize: 50, weight: .light)
        return label
    }()
    
    let onOffSwitch: UISwitch = {
        let switchView = UISwitch()
        return switchView
    }()
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    @objc func switchValueChanged(_ sender: UISwitch) {
        guard let data = UserDefaults.standard.value(forKey: "alerts") as? Data,
              var alerts = try? PropertyListDecoder().decode([Alert].self, from: data) else { return }
        alerts[sender.tag].isOn = sender.isOn
        UserDefaults.standard.set(try? PropertyListEncoder().encode(alerts), forKey: "alerts")
        if sender.isOn {
            userNotificationCenter.addNotificationRequest(by: alerts[sender.tag])
        } else {
            userNotificationCenter.removePendingNotificationRequests(withIdentifiers: [alerts[sender.tag].id])
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.isUserInteractionEnabled = true
        setupView()
        setupConstraints()
        onOffSwitch.addTarget(self, action: #selector(switchValueChanged(_:)), for: .valueChanged)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func setupView() {
        addSubview(meridiemLabel)
        addSubview(timeLabel)
        addSubview(onOffSwitch)
    }
    
    func setupConstraints() {
        meridiemLabel.snp.makeConstraints {
            $0.leading.equalTo(20)
        }
        
        timeLabel.snp.makeConstraints {
            $0.leading.equalTo(meridiemLabel.snp.trailing).offset(12)
            $0.centerY.equalToSuperview()
            $0.bottom.equalTo(meridiemLabel.snp.bottom).offset(8)
        }
        
        onOffSwitch.snp.makeConstraints {
            $0.trailing.equalTo(-20)
            $0.centerY.equalToSuperview()
        }
    }
}
