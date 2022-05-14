//
//  NoticeViewController.swift
//  RealtimeNotice
//
//  Created by Sang hun Lee on 2022/05/13.
//

import UIKit

class NoticeViewController: UIViewController {
    let noticeView = NoticeView()
    
    var noticeContents: (title: String, detail: String, date: String)?
    
    override func loadView() {
        super.loadView()
        self.view = noticeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        noticeView.closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        noticeView.containerView.layer.cornerRadius = 6
        
        guard let noticeContents = self.noticeContents else { return }
        
        noticeView.subtitleLabel.text = noticeContents.title
        noticeView.descLabel.text = noticeContents.detail
        noticeView.termDescLabel.text = noticeContents.date
    }
    
    @objc func closeButtonTapped() {
        self.dismiss(animated: true, completion: nil)
    }
}


