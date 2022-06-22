//
//  AddAlertViewController.swift
//  WaterDrink
//
//  Created by Sang hun Lee on 2022/05/14.
//

import UIKit

class AddAlertViewController: UIViewController {

    let addAlertView = AddAlertView()
    var pickedDate: ((_ date: Date) -> ())?
    
    override func loadView() {
        super.loadView()
        self.view = addAlertView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigation()
    }
    
    func setNavigation() {
        let screenSize: CGRect = UIScreen.main.bounds
        let navBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: 44))
        let navItem = UINavigationItem(title: "알람 추가")
        let cancelBarButtonItem = UIBarButtonItem(title: "취소", style: .done, target: self, action: #selector(cancelBarButtonTapped))
        navItem.leftBarButtonItem  = cancelBarButtonItem
        
        let saveBarButtonItem = UIBarButtonItem(title: "저장", style: .done, target: self, action: #selector(saveBarButtonItemTapped))
        navItem.rightBarButtonItem  = saveBarButtonItem
        navBar.setItems([navItem], animated: false)
        self.view.addSubview(navBar)
    }
    
    @objc func cancelBarButtonTapped() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func saveBarButtonItemTapped() {
        pickedDate?(addAlertView.datePicker.date)
        self.dismiss(animated: true, completion: nil)
    }
}
